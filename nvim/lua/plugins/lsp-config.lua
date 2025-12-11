return {
    -- Mason para instalar LSP servers
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end
    },

    -- Mason-lspconfig para integrar Mason con lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "ts_ls",
                    "pyright",
                    "html",
                    "cssls",
                    "jsonls",
                },
                automatic_installation = true,
            })
        end
    },

    -- LSP Config
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            -- Suprimir el warning de deprecación
            local notify = vim.notify
            vim.notify = function(msg, ...)
                if msg:match("require%(.*lspconfig.*%)") then
                    return
                end
                if type(msg) == "string" and (
                    string.match(msg, "clangd.*quit with exit code") or
                    string.match(msg, "Client.*quit with exit code") or
                    string.match(msg, "Check log for errors:")
                ) then
                    return
                end
                notify(msg, ...)
            end

            -- Configuración de diagnósticos
            vim.diagnostic.config({
                virtual_text = {
                    prefix = '●',
                    source = "if_many",
                    severity = { min = vim.diagnostic.severity.WARN },
                    format = function(diagnostic)
                        if string.match(diagnostic.message, "not used directly") or
                           string.match(diagnostic.message, "fixes available") or
                           string.match(diagnostic.message, "Included header.*is not used directly") then
                            return ""
                        end
                        return diagnostic.message
                    end
                },
                float = {
                    source = "if_many",
                    severity_sort = true,
                    border = "rounded",
                },
                signs = {
                    severity = { min = vim.diagnostic.severity.WARN },
                },
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })

            -- Símbolos para los signos de diagnóstico
            local signs = {
                Error = " ",
                Warn = " ",
                Hint = " ",
                Info = " "
            }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            -- Función on_attach común para todos los LSPs
            local on_attach = function(client, bufnr)
                vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

                local opts = { noremap = true, silent = true, buffer = bufnr }

                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)

                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)

                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)

                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)

                vim.keymap.set('n', '<space>f', function()
                    vim.lsp.buf.format { async = true }
                end, opts)

                vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
                vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
                vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
                vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
            end

            -- Capacidades mejoradas
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
            if has_cmp then
                capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
            else
                capabilities.textDocument.completion.completionItem.snippetSupport = true
                capabilities.textDocument.completion.completionItem.resolveSupport = {
                    properties = {
                        'documentation',
                        'detail',
                        'additionalTextEdits',
                    }
                }
            end

            -- Usar require lspconfig (sí, con el warning suprimido arriba)
            local lspconfig = require('lspconfig')

            -- Configuración específica para clangd
            lspconfig.clangd.setup({
                cmd = {
                    "clangd",
                    "--background-index",
                    "--query-driver=/usr/bin/arm-none-eabi-gcc",
                    "--all-scopes-completion",
                    "--completion-style=detailed",
                    "--function-arg-placeholders=true",
                    "-j=4",
                    "--header-insertion=never",
                    "--pch-storage=memory",
                    "--compile-flags-ignore=-fno-reorder-functions",
                    "--enable-config",
                    "--log=error",
                    "--compile-commands-dir=build",
                    "--header-insertion-decorators=0",
                },
                filetypes = {"c", "cpp", "objc", "objcpp"},
                root_dir = lspconfig.util.root_pattern(
                    "compile_commands.json",
                    "compile_flags.txt",
                    ".clangd",
                    "build",
                    ".git"
                ),
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    client.server_capabilities.semanticTokensProvider = nil
                end,
                capabilities = capabilities,
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = false,
                    clangdFileStatus = true,
                    fallbackFlags = {
                        "-xc",
                        "--target=arm-none-eabi",
                        "-DZEPHYR=1",
                        "-DCONFIG_ARM=1",
                        "-I${workspaceFolder}/include",
                        "-I${workspaceFolder}/deps/zephyr/include",
                        "-I${workspaceFolder}/deps/zephyr/include/zephyr",
                        "-I.",
                        "-I./include",
                        "-I./src",
                        "-std=gnu11",
                        "-nostdinc",
                        "--target=arm-none-eabi",
                        "-DCONFIG_ARCH_HAS_CUSTOM_BUSY_WAIT=1",
                        "-DCONFIG_HAS_DTS=1",
                        "-Wno-unused-but-set-variable",
                        "-Wno-unused-variable",
                        "-Wno-unused-function",
                    }
                },
                flags = {
                    debounce_text_changes = 150,
                },
            })

            -- Otros LSPs
            lspconfig.ts_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities
            })

            lspconfig.pyright.setup({
                on_attach = on_attach,
                capabilities = capabilities
            })

            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = {'vim'},
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })

            lspconfig.html.setup({
                on_attach = on_attach,
                capabilities = capabilities
            })

            lspconfig.cssls.setup({
                on_attach = on_attach,
                capabilities = capabilities
            })

            lspconfig.jsonls.setup({
                on_attach = on_attach,
                capabilities = capabilities
            })
        end
    }
}

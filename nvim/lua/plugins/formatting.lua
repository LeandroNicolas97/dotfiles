return {
    -- Agregar conform.nvim para manejar el formateo
    {
        "stevearc/conform.nvim",
        opts = {
            -- Configuración de formateadores por tipo de archivo
            formatters_by_ft = {
                c = { "clang_format" },
                cpp = { "clang_format" },
                h = { "clang_format" },
            },
            -- Configuración específica para clang-format
            formatters = {
                clang_format = {
                    -- Usar el archivo .clang-format del proyecto
                    prepend_args = { "--style=file" },
                },
            },
        },
        -- Inicialización del plugin
        init = function()
            -- Registrar el comando :Format para uso desde la línea de comandos
            vim.api.nvim_create_user_command("Format", function(args)
                local range = nil
                if args.count ~= -1 then
                    local end_line = vim.fn.line(".")
                    range = {
                        start = { args.line1, 0 },
                        ["end"] = { end_line, 0 },
                    }
                end
                require("conform").format({ async = true, lsp_fallback = true, range = range })
            end, { range = true })

            -- Configurar el atajo de teclado <leader>cf para formateo
            vim.keymap.set({ "n", "v" }, "<leader>kk", function()
                require("conform").format({
                    lsp_fallback = true,
                    async = true,
                })
            end, { desc = "Format file or range (in visual mode)" })
        end,
    },

    -- Desactivar el formateo de none-ls si está presente
    {
        "nvimtools/none-ls.nvim",
        optional = true,
        opts = function(_, opts)
            if type(opts.sources) == "table" then
                local nls = require("null-ls")
                opts.sources = vim.tbl_filter(function(source)
                    return source.name ~= "clang_format"
                end, opts.sources)
            end
        end,
    },
}

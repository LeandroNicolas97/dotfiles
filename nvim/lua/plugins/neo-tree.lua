return {
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        config = function()
            vim.cmd("colorscheme tokyonight-moon")

            vim.defer_fn(function()
                vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "NONE", fg = "NONE" })
                vim.api.nvim_set_hl(0, "NeoTreeVertSplit", { bg = "NONE", fg = "#3d59a1" })
                vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "NONE", fg = "#3d59a1" })
            end, 50)

            require("neo-tree").setup({
                close_if_last_window = true,
                enable_git_status = true,
                enable_diagnostics = true,
                filesystem = {
                    filtered_items = {
                        visible = false,
                        hide_dotfiles = true,
                        hide_gitignored = false,
                        -- Excluir directorios con ':' en el nombre
                        never_show = {
                            "term:",
                            "term:/~",
                            -- Puedes agregar otros patrones problemáticos aquí
                        },
                    },
                    follow_current_file = { enabled = false },
                    use_libuv_file_watcher = true,

                    bind_to_cwd = true,
                    window = {
                        mappings = {
                            ["<CR>"] = "open_with_window_picker",
                            ["o"] = "open",
                            ["O"] = "open_with_window_picker",
                        },
                    },
                },
                default_component_configs = {
                    icon = {
                        folder_closed = "",
                        folder_open = "",
                        folder_empty = "",
                        default = "",
                    },
                    modified = { symbol = "[+]" },
                    git_status = {
                        symbols = {
                            added     = "✚",
                            deleted   = "✖",
                            modified  = "",
                            renamed   = "",
                            untracked = "",
                            ignored   = "",
                            unstaged  = "✗",
                            staged    = "✓",
                            conflict  = "",
                        },
                    },
                    name = {
                        use_git_status_colors = true,
                        highlight = "NeoTreeFileName",
                    },
                },
                window = {
                    width = 35,
                    mappings = {
                        ["<CR>"] = "open_with_window_picker",
                        ["o"] = "open",
                        ["O"] = "open_with_window_picker",
                    },
                },
            })

            vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left toggle<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>f', ':Neotree focus<CR>', { noremap = true, silent = true })
        end
    }
}

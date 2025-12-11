return {
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("barbar").setup({
                icons = {
                    filetype = { enabled = true },
                    separator = { left = "▎" },
                    inactive = {
                        separator = { left = "▎" },
                    },
                    buffer_index = true,
                },
                auto_hide = true,
                maximum_padding = 2,
                maximum_length = 30,
            })

            -- Configuración de atajos de teclado
            local map = vim.api.nvim_set_keymap
            local opts = { noremap = true, silent = true }

            -- Saltar a buffers específicos usando Tab + número
            for i = 1, 9 do
                map("n", "<Tab>" .. i, ":BufferGoto " .. i .. "<CR>", opts)
            end
            map("n", "<Tab>0", ":BufferLast<CR>", opts)

            -- Doble Tab para siguiente buffer
            map("n", "<Tab><Tab>", ":BufferNext<CR>", opts)

            -- Shift+Tab para buffer anterior
            map("n", "<S-Tab>", ":BufferPrevious<CR>", opts)

            -- Cerrar buffer
            map("n", "<leader>c", ":BufferClose<CR>", opts)
        end,
    },
}

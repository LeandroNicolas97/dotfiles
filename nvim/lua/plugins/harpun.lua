return {
    {
        "theprimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup({
                menu = {
                    width = vim.api.nvim_win_get_width(0) - 20,  -- Ajusta el ancho
                    height = 10,  -- Ajusta la altura
                },
            })

            -- Cambiar colores usando 'nvim_set_hl'
            vim.api.nvim_set_hl(0, "HarpoonWindow", { fg = "#A3BE8C", bg = "#2E3440" }) -- Color de la ventana
            vim.api.nvim_set_hl(0, "HarpoonBorder", { fg = "#88C0D0", bg = "#2E3440" }) -- Borde
            vim.api.nvim_set_hl(0, "HarpoonTitle", { fg = "#EBCB8B", bold = true }) -- Título destacado
        end,
    },
}

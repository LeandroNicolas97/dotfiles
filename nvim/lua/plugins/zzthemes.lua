return {
-------------------------------------------------
{
    "folke/tokyonight.nvim",
    config = function()
        require("tokyonight").setup({
            transparent = true,    -- Fondo transparente
            terminal_colors = true,-- Aplica colores a terminales integrados
            dim_inactive = false,  -- Atenúa ventanas inactivas
            styles = {
                comments = { italic = true },
                keywords = { italic = false },
                functions = {},
                variables = {},
            },
            on_colors = function(colors)
                colors.bg = "#1a1b26"  -- Color de fondo original
                colors.comment = "#6272a4"
                colors.error = "#ff5555"
                colors.warning = "#ffb86c"
            end,
            on_highlights = function(hl, colors)
                hl.LineNr = { fg = colors.purple }
            end
        })

        -- Aplicar esquema de colores antes de cualquier otra configuración
        vim.cmd("colorscheme tokyonight-moon")
    end,
},

----------------------------------------------------
    -- {
    --     "catppuccin/nvim",
    --     as = "catppuccin",
    --     config = function()
    --         require("catppuccin").setup({
    --             flavour = "macchiato", -- Variantes: latte, frappe, macchiato, mocha
    --             transparent_background = true, -- Fondo transparente
    --         })
    --         vim.cmd [[colorscheme catppuccin]]
    --     end,
    -- },
----------------------------------------------------
    -- {
    --     "EdenEast/nightfox.nvim",
    --     config = function()
    --         require("nightfox").setup({
    --             options = {
    --                 transparent = true, -- Fondo transparente
    --                 styles = {
    --                     comments = "italic",
    --                     keywords = "bold",
    --                     types = "italic,bold",
    --                 },
    --             }
    --         })
    --         vim.cmd("colorscheme nordfox") -- Variantes: nightfox, dayfox, dawnfox, duskfox, nordfox, carbonfox
    --     end,
    -- },
---------------------------------------------------
    -- {
    --     "sainnhe/gruvbox-material",
    --     config = function()
    --         vim.g.gruvbox_material_background = "hard" -- Variantes: hard, medium (default), soft
    --         vim.g.gruvbox_material_transparent_background = 1 -- Fondo transparente
    --         vim.cmd([[colorscheme gruvbox-material]])
    --     end,
    -- },
---------------------------------------------------
--     {
--         "sainnhe/everforest",
--         config = function()
--             vim.g.everforest_background = "medium" -- Variantes: hard, medium (default), soft
--             vim.g.everforest_transparent_background = 1 -- Fondo transparente
--             vim.cmd("colorscheme everforest")
--         end,
--     },
-- ---------------------------------------------------
    -- {
    --     "arcticicestudio/nord-vim", -- El tema Nord no tiene variantes de color configurables
    --     config = function()
    --         vim.g.nord_cursor_line_number_background = 1
    --         vim.g.nord_uniform_status_lines = 1
    --         -- Configuración manual para transparencia
    --         vim.cmd[[
    --             highlight Normal guibg=NONE ctermbg=NONE
    --             highlight NonText guibg=NONE ctermbg=NONE
    --         ]]
    --         vim.cmd [[colorscheme nord]]
    --     end,
    -- },
---------------------------------------------------
}

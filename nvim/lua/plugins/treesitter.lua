return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "python",
                    "lua",
                    "c",
                    "cpp",           -- Agregado para mejor soporte de C++
                    "javascript",
                    "typescript",    -- Agregado para TypeScript
                    "cmake",
                    "yaml",
                    "markdown",      -- Necesario para LSP hover
                    "markdown_inline", -- Necesario para LSP hover
                    "json",          -- Útil para archivos JSON
                    "html",          -- Para HTML
                    "css"            -- Para CSS
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true }
            })
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-context'
    }
}

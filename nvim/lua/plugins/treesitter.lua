return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter').install({
                "python", "lua", "rust", "toml", "c", "cpp",
                "javascript", "typescript", "cmake", "yaml",
                "markdown", "markdown_inline", "json", "html", "css",
                "git_rebase", "hyprlang",
            })
            vim.treesitter.language.register('json', 'jsonc')
            vim.treesitter.language.register('git_rebase', 'gitrebase')

            vim.filetype.add({
                pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
            })

            vim.api.nvim_create_autocmd('FileType', {
                callback = function()
                    pcall(vim.treesitter.start)
                    vim.bo.indentexpr = 'v:lua.vim.treesitter.indentexpr()'
                end,
            })
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        enabled = false
    }
}

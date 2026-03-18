return {
    {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        config = function()
            require("crates").setup({
                completion = {
                    cmp = { enabled = true },
                },
            })

            -- Keymaps para Cargo.toml
            vim.api.nvim_create_autocmd("BufRead", {
                pattern = "Cargo.toml",
                callback = function(ev)
                    local opts = { silent = true, buffer = ev.buf }
                    vim.keymap.set("n", "<leader>cv", require("crates").show_versions_popup, opts)
                    vim.keymap.set("n", "<leader>cf", require("crates").show_features_popup, opts)
                    vim.keymap.set("n", "<leader>cu", require("crates").update_crate, opts)
                    vim.keymap.set("n", "<leader>cU", require("crates").update_all_crates, opts)
                end,
            })
        end,
    },
}

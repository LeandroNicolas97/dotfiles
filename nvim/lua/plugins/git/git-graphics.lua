
return {
  -- Vim-Fugitive: Herramienta poderosa para Git dentro de Neovim
  {
    "tpope/vim-fugitive",
    cmd = { "Git" }, -- Solo carga el plugin cuando ejecutas un comando relacionado
    keys = {
      { "<leader>gs", ":Git<CR>", desc = "Abrir status de Git (Fugitive)" },
    },
    config = function()
      vim.api.nvim_set_keymap(
        "n",
        "<leader>gb",
        ":Git branch<CR>",
        { noremap = true, silent = true, desc = "Ver ramas de Git (Fugitive)" }
      )
    end,
  },

  -- LazyGit.nvim: Interfaz gráfica dentro de Neovim
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit" }, -- Solo carga el plugin cuando ejecutas el comando LazyGit
    keys = {
      -- { "<leader>gg", ":LazyGit<CR>", desc = "Abrir LazyGit" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.api.nvim_set_keymap(
        "n",
        "<leader>gl",
        ":LazyGit<CR>",
        { noremap = true, silent = true, desc = "Abrir LazyGit" }
      )
    end,
  },
}

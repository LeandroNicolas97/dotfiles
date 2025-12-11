local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.g.python3_host_prog = '/home/leandro/git/phmeter/.venv/bin/python3'
-- Disable Ctrl+z in all modes
vim.keymap.set('n', '<C-z>', '<nop>', { noremap = true })
vim.keymap.set('i', '<C-z>', '<nop>', { noremap = true })

vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
--Leader
vim.g.mapleader = ' '

vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
require("vim-options")

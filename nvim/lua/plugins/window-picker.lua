-- ~/.config/nvim/lua/plugins/window-picker.lua
return {
  "s1n7ax/nvim-window-picker",
  config = function()
    require("window-picker").setup({
      autoselect_one = true,
      include_current = true,
      fg_color = "#FFA07A",               -- Color de la letra
      current_win_hl_color = "#247997",   -- Color para la ventana actual
      other_win_hl_color = "#7B2497",     -- Color para las otras ventanas
    })

    -- Atajo para abrir el selector de ventanas
    vim.api.nvim_set_keymap(
      'n',
      '<leader>w',
      ":lua require'window-picker'.pick_window()<CR>",
      { noremap = true, silent = true }
    )
  end
}

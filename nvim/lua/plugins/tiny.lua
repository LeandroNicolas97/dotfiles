return {
  {
    "rachartier/tiny-glimmer.nvim",
    config = function()
      require("tiny-glimmer").setup({
        default_animation = "rainbow", -- Puedes cambiar a "fade", "bounce", "pulse", "rainbow", "custom", "left_to_right", "reverse_fade" etc.
        transparency_color = "#ff5733", -- Ajusta este valor si usas un fondo transparente
      })
    end,
  },
}

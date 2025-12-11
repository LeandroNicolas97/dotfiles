
return {
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        toggler = {
          line = "gc", -- Toggle para una línea
        },
        opleader = {
          line = "gc", -- Toggle para el modo visual
        },
        mappings = {
          basic = true, -- Activa las combinaciones básicas (gc)
          extra = true, -- Activa combinaciones extra (gcA, etc.)
        },
        pre_hook = function(ctx)
          -- Esto es opcional: añade compatibilidad con integraciones como `ts_context_commentstring`
        end,
      })
    end,
    event = "VeryLazy", -- Opcional: Carga el plugin bajo demanda
  },
}

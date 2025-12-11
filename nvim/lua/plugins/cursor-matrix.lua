-- Configuración del plugin SmoothCursor.nvim para lazy.nvim

--[[
TIPOS DE ANIMACIÓN DISPONIBLES:
-----------------------------
Para cambiar el tipo de animación, modifica el valor de 'type' en la configuración.

1. "default" - La animación estándar con un movimiento suave
2. "exp"     - Movimiento exponencial que se acelera y desacelera
3. "sigmoid" - Movimiento suavizado con curva sigmoidea
4. "quadratic" - Movimiento con aceleración cuadrática
5. "cubic"   - Similar a quadratic pero con curva más pronunciada
6. "magic"   - Combina diferentes tipos de animación
7. "linear"  - Movimiento constante sin aceleración

sl efecto Matrix se activa automáticamente al mover el cursor hacia abajo
--]]

-- Caracteres para el efecto Matrix
-- Configuración del plugin SmoothCursor.nvim para lazy.nvim

-- Caracteres para el efecto Matrix
-- local matrix_chars = {
--     'ｱ', 'ｲ', 'ｳ', 'ｴ', 'ｵ',
--     'ｶ', 'ｷ', 'ｸ', 'ｹ', 'ｺ',
--     'ｻ', 'ｼ', 'ｽ', 'ｾ', 'ｿ',
--     'ﾀ', 'ﾁ', 'ﾂ', 'ﾃ', 'ﾄ',
--     'ﾅ', 'ﾆ', 'ﾇ', 'ﾈ', 'ﾉ',
--     'ﾊ', 'ﾋ', 'ﾌ', 'ﾍ', 'ﾎ',
--     'ﾏ', 'ﾐ', 'ﾑ', 'ﾒ', 'ﾓ',
--     'ﾔ', 'ﾕ', 'ﾖ',
--     'ﾗ', 'ﾘ', 'ﾙ', 'ﾚ', 'ﾛ',
--     'ﾜ', 'ｦ', 'ﾝ', '-',
--     'Γ', 'Δ', 'Λ', 'Ξ', 'Π',
--     'Σ', 'Φ', 'Χ', 'Ψ', 'Ω',
--     'α', 'β', 'γ', 'δ', 'ε',
--     'ζ', 'η', 'θ', 'ι', 'κ',
--     'λ', 'μ', 'ν', 'ξ', 'ο',
--     'π', 'ρ', 'σ', 'τ', 'υ',
--     'φ', 'ψ', 'ω'
-- }
-- Caracteres para el efecto Matrix

local up_chars = {''}  -- Flechas hacia arriba
local down_chars = {' '}  -- Flechas hacia abajo

-- Caracteres especiales para el cursor principal
local head_chars = {''}
local head_chars2 = {'◈', '◆', '❖', '⚝', '✴'}

local last_y = vim.fn.line('.')
local current_chars = down_chars  -- Inicialmente, se asume que baja

return {
  {
    "gen740/SmoothCursor.nvim",
    config = function()
      local function generate_body(length)
        local body = {}
        local chars_length = #current_chars
        for i = 1, length do
          local char_index = math.random(1, chars_length)
          local red_intensity = math.floor(102 * (1 - i/length))
          local green_intensity = math.floor(204 * (1 - i/length))
          local blue_intensity = math.floor(255 * (1 - i/length))
          local hl_group = string.format("SmoothCursor_%d", i)

          vim.api.nvim_command(string.format(
            'highlight %s guifg=#%02x%02x%02x gui=bold',
            hl_group,
            red_intensity,
            green_intensity,
            blue_intensity
          ))
          table.insert(body, {
            cursor = current_chars[char_index],
            texthl = hl_group
          })
        end
        return body
      end

      local function update_cursor_direction()
        local current_y = vim.fn.line('.')
        if current_y < last_y then
          current_chars = up_chars
        elseif current_y > last_y then
          current_chars = down_chars
        end
        last_y = current_y
      end

      require("smoothcursor").setup({
        type = "default",
        autostart = true,
        timeout = 3000,
        threshold = 3,
        modes = {
          ["n"] = "block",
          ["i"] = "line",
          ["v"] = "underline",
        },
        fancy = {
          enable = true,
          head = {
            cursor = head_chars[math.random(1, #head_chars)],
            texthl = "SmoothCursorHead",
          },
          body = generate_body(30),
        },
        speed = 15,
        disabled_filetypes = {
          "TelescopePrompt",
          "NvimTree",
          "neo-tree",
        },
      })

      vim.api.nvim_command('highlight SmoothCursorHead guifg=#66ccff gui=bold')

      vim.api.nvim_create_autocmd("CursorMoved", {
        callback = function()
          update_cursor_direction()
          require("smoothcursor").setup({ fancy = { body = generate_body(30) } })
        end
      })
    end,
  },
}

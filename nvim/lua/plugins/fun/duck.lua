return {
    {
        'tamton-aquib/duck.nvim',
        config = function()
            local duck = require("duck")

            -- Configura el número de emojis para cada tipo
            local number_of_emojis = 30

            -- Define las tres figuras diferentes
            local figure1 = "🍺"
            local figure2 = "🤬"
            local figure3 = "💜"

            -- Genera tres listas de emojis
            local emojis1 = {}
            local emojis2 = {}
            local emojis3 = {}
            for i = 1, number_of_emojis do
                table.insert(emojis1, figure1)
                table.insert(emojis2, figure2)
                table.insert(emojis3, figure3)
            end

            -- Función para generar el primer tipo de emoji
            local function hatch_multiple1()
                for _, emoji in ipairs(emojis1) do
                    duck.hatch(emoji, math.random(10, 30))
                end
            end

            -- Función para generar el segundo tipo de emoji
            local function hatch_multiple2()
                for _, emoji in ipairs(emojis2) do
                    duck.hatch(emoji, math.random(10, 30))
                end
            end

            -- Función para generar el tercer tipo de emoji
            local function hatch_multiple3()
                for _, emoji in ipairs(emojis3) do
                    duck.hatch(emoji, math.random(10, 30))
                end
            end

            -- Mapeos para cada figura
            vim.keymap.set('n', '<leader>da', hatch_multiple1, { desc = "Spawn angry bees" })
            vim.keymap.set('n', '<leader>ds', hatch_multiple2, { desc = "Spawn lion foxes" })
            vim.keymap.set('n', '<leader>dd', hatch_multiple3, { desc = "Spawn dragons" })

            -- Mapeo para eliminar todos
            vim.keymap.set('n', '<leader>dk', function() duck.cook_all() end, { desc = "Remove all emojis" })
        end
    }
}

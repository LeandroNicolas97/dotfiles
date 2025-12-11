vim.cmd("set number")
vim.cmd("set mouse=a")
vim.cmd("syntax enable")
vim.cmd("set showcmd")
vim.cmd("set encoding=utf-8")
vim.cmd("set showmatch")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=0")
vim.cmd("set softtabstop=0")
vim.cmd("set autoindent")
vim.cmd("set smarttab")
vim.cmd("let @/ = ''")
vim.opt.relativenumber = true
vim.opt.shortmess:append("A")

-- Mover a la ventana izquierda (Alt + j)
vim.keymap.set('n', '<C-Right>', '<C-w>h', { noremap = true, silent = true, desc = 'Mover a la ventana izquierda' })

-- Mover a la ventana derecha (Alt + l)
vim.keymap.set('n', '<C-Left>', '<C-w>l', { noremap = true, silent = true, desc = 'Mover a la ventana derecha' })

-- Mover a la ventana de arriba (Alt + i)
vim.keymap.set('n', '<C-Up>', '<C-w>k', { noremap = true, silent = true, desc = 'Mover a la ventana de arriba' })

-- Mover a la ventana de abajo (Alt + k)
vim.keymap.set('n', '<C-Down>', '<C-w>j', { noremap = true, silent = true, desc = 'Mover a la ventana de abajo' })
-- Función para cambiar de ventana repetidamente
local function repeatable_move(direction)
    return function()
        vim.cmd('wincmd ' .. direction)                                            -- Ejecuta el comando de movimiento
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Ignore>', true, false, true)) -- Ignora la tecla presionada
    end
end

vim.keymap.set("n", "<C-+>", ":lua vim.o.guifontsize = vim.o.guifontsize + 1<CR>")
vim.keymap.set("n", "<C-->", ":lua vim.o.guifontsize = vim.o.guifontsize - 1<CR>")
vim.keymap.set('n', '<C-Left>', '<C-w>h', {})                                                                                    -- Mover a la ventana izquierda
vim.keymap.set('n', '<C-Right>', '<C-w>l', {})                                                                                   -- Mover a la ventana derecha
vim.keymap.set('n', '<C-Up>', '<C-w>k', {})                                                                                      -- Mover a la ventana de arriba
vim.keymap.set('n', '<C-Down>', '<C-w>j', {})                                                                                    -- Mover a la ventana de abajo

-- Mapea Ctrl+W en modo terminal para permitir la navegación entre ventanas
vim.api.nvim_set_keymap('t', '<C-w>', [[<C-\><C-n><C-w>]], { noremap = true, silent = true })
vim.cmd("set smartcase")


-- Cerrar ventana y buffer actual
vim.cmd("command! CloseWindow bdelete")
vim.keymap.set('n', '<Leader>q', ':CloseWindow<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>t', ':terminal<CR>', { noremap = true, silent = true })

-- Función para limpiar la búsqueda de palabras cada vez que se realiza una
vim.api.nvim_create_autocmd("CmdlineLeave", {
    pattern = "/,?",
    callback = function()
        vim.cmd("let @/ = ''")
    end,
})

-- Configuración para copiar y pegar con Ctrl+c y Ctrl+v
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true }) -- Copiar con Ctrl+c
vim.api.nvim_set_keymap('n', '<C-v>', '"+p', { noremap = true, silent = true }) -- Pegar con Ctrl+v en modo normal
vim.api.nvim_set_keymap('v', '<C-v>', '"+p', { noremap = true, silent = true }) -- Pegar con Ctrl+v en modo visual

vim.keymap.set("n", "<S-Tab>", vim.cmd.bprevious)                               -- Moverse entre buffers

-- Mapea Ctrl+W en modo terminal para permitir la navegación entre ventanas
vim.api.nvim_set_keymap('t', '<C-w>', [[<C-\><C-n><C-w>]], { noremap = true, silent = true })


-- then you need to set the option below.
vim.g.lazyvim_picker = "telescope"
-- Keymaps para buscar archivos y hacer live grep con Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", function()
    builtin.find_files({
        hidden = true,
        no_ignore = true,
    })
end, { noremap = true, silent = true, desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function()
    builtin.live_grep({
        hidden = true,
        no_ignore = true,
    })
end, { noremap = true, silent = true, desc = "Live grep" })
-- -- Nuevo keymap para buscar la palabra bajo el cursor en Telescope
-- vim.keymap.set("n", "<leader>gg", function()
--     builtin.grep_string({
--         word_match = "-w",
--         hidden = true,
--         no_ignore = true,
--     })
-- end, { noremap = true, silent = true, desc = "Buscar palabra bajo el cursor" })

--remaps for harpoon
local harpoon = require("harpoon")

vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)
vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set('n', '<leader>1', function() harpoon:list():select(1) end)
vim.keymap.set('n', '<leader>2', function() harpoon:list():select(2) end)
vim.keymap.set('n', '<leader>3', function() harpoon:list():select(3) end)
vim.keymap.set('n', '<leader>4', function() harpoon:list():select(4) end)
vim.keymap.set('n', '<leader>5', function() harpoon:list():select(5) end)
vim.keymap.set('n', '<leader>6', function() harpoon:list():select(6) end)
-- vim.keymap.set('n', '<Tab>', function() harpoon:list():prev() end)
-- vim.keymap.set('n', '<S-Tab>', function() harpoon:list():next() end)

-- Redimensionar ventanas con Control + Shift + flechas
vim.keymap.set("n", "<C-S-Down>", "<Cmd>resize -2<CR>", { noremap = true, silent = true, desc = "Disminuir altura de la ventana" })  -- Disminuir alto
vim.keymap.set("n", "<C-S-Up>", "<Cmd>resize +2<CR>", { noremap = true, silent = true, desc = "Aumentar altura de la ventana" })   -- Aumentar alto
vim.keymap.set("n", "<C-S-Right>", "<Cmd>vertical resize +2<CR>", { noremap = true, silent = true, desc = "Aumentar ancho de la ventana" })  -- Aumentar ancho
vim.keymap.set("n", "<C-S-Left>", "<Cmd>vertical resize -2<CR>", { noremap = true, silent = true, desc = "Disminuir ancho de la ventana" })  -- Disminuir ancho

-- remap to replace words
--vim.keymap.set('n', '<leader>p', ':%s/\\<<C-r><C-w>\\>//c<Left><Left>', { noremap = true, silent = true })

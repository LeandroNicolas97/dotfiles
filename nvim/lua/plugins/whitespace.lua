-- lua/plugins/whitespace.lua
return {
    "ntpeters/vim-better-whitespace",
    config = function()
        vim.g.better_whitespace_enabled = 1       -- Habilita el resaltado de espacios en blanco
        vim.g.strip_whitespace_on_save = 1        -- Elimina espacios en blanco al guardar
        vim.g.strip_whitelines_at_eof = 1         -- Elimina líneas en blanco al final del archivo
    end
}


# Neovim Keybindings

> `<leader>` = `\` (backslash)

---

## Navegación entre ventanas

| Tecla | Acción |
|-------|--------|
| `Ctrl+→` | Mover a ventana derecha |
| `Ctrl+←` | Mover a ventana izquierda |
| `Ctrl+↑` | Mover a ventana arriba |
| `Ctrl+↓` | Mover a ventana abajo |

## Redimensionar ventanas

| Tecla | Acción |
|-------|--------|
| `Alt+i` | Aumentar alto |
| `Alt+k` | Disminuir alto |
| `Alt+l` | Aumentar ancho |
| `Alt+j` | Disminuir ancho |

---

## Buffers / Pestañas

| Tecla | Acción |
|-------|--------|
| `Tab+1` … `Tab+9` | Ir al buffer 1-9 |
| `Tab+0` | Ir al último buffer |
| `Tab+Tab` | Buffer siguiente |
| `Shift+Tab` | Buffer anterior |
| `<leader>q` | Cerrar buffer actual |

---

## Explorador de archivos (Neo-tree)

| Tecla | Acción |
|-------|--------|
| `Ctrl+n` | Abrir/cerrar explorador |
| `<leader>f` | Enfocar Neo-tree |
| `Enter` / `o` | Abrir archivo |
| `O` | Abrir con selector de ventana |

---

## Búsqueda (Telescope)

| Tecla | Acción |
|-------|--------|
| `<leader>ff` | Buscar archivos (incluye ocultos) |
| `<leader>fg` | Buscar texto en el proyecto (live grep) |
| `Ctrl+s` | Buscar archivos |
| `Ctrl+g` | Live grep |

---

## Harpoon (marcadores rápidos)

| Tecla | Acción |
|-------|--------|
| `<leader>a` | Agregar archivo actual |
| `Ctrl+e` | Abrir menú de Harpoon |
| `<leader>1` … `<leader>6` | Ir al archivo marcado 1-6 |

---

## LSP — Navegación de código

| Tecla | Acción |
|-------|--------|
| `gd` | Ir a definición |
| `gD` | Ir a declaración |
| `gi` | Ir a implementación |
| `gr` | Ver referencias |
| `K` | Ver documentación (hover) |
| `Ctrl+k` | Ver firma de función |
| `<space>D` | Ir a definición de tipo |
| `[d` | Diagnóstico anterior |
| `]d` | Diagnóstico siguiente |
| `<space>e` | Ver diagnóstico en float |
| `<space>q` | Lista de diagnósticos |

## LSP — Acciones de código

| Tecla | Acción |
|-------|--------|
| `<space>rn` | Renombrar símbolo |
| `<space>ca` | Acciones de código |
| `<space>f` | Formatear archivo |
| `<leader>kk` | Formatear archivo o selección |
| `:Format` | Comando de formato |

---

## Autocompletado (cmp)

| Tecla | Acción |
|-------|--------|
| `Ctrl+Space` | Activar completado |
| `Tab` | Siguiente sugerencia |
| `Shift+Tab` | Sugerencia anterior |
| `Enter` | Confirmar selección |
| `Ctrl+e` | Cerrar completado |
| `Ctrl+b` | Scroll doc arriba |
| `Ctrl+f` | Scroll doc abajo |

---

## Git

| Tecla | Acción |
|-------|--------|
| `<leader>gs` | Git status (Fugitive) |
| `<leader>gb` | Git branches |
| `<leader>gl` | Abrir LazyGit |
| `:DiffviewOpen` | Ver diff de todos los cambios |
| `:DiffviewClose` | Cerrar Diffview |
| `]c` | Siguiente cambio (en Diffview) |
| `[c` | Cambio anterior (en Diffview) |

---

## Diagnósticos

| Tecla | Acción |
|-------|--------|
| `<leader>dd` | Toggle todos los diagnósticos |
| `<leader>dw` | Toggle warnings (mantiene errores) |

---

## Comentarios

| Tecla | Acción |
|-------|--------|
| `gc` | Toggle comentario de línea (normal y visual) |

---

## Copiar / Pegar

| Tecla | Acción |
|-------|--------|
| `Ctrl+c` | Copiar selección al clipboard (visual) |
| `Ctrl+v` | Pegar desde clipboard (normal y visual) |

---

## Terminal

| Tecla | Acción |
|-------|--------|
| `<leader>t` | Abrir terminal |
| `Ctrl+w` | Salir del modo terminal y navegar ventanas |

---

## Búsqueda y reemplazo

| Tecla | Acción |
|-------|--------|
| `<leader>p` | Reemplazar palabra bajo el cursor (con confirmación) |

---

## Markdown

| Tecla | Acción |
|-------|--------|
| `Ctrl+p` | Toggle preview de Markdown |

---

## Lenguajes específicos

### Rust

> Usa `rustaceanvim`. Los keymaps de LSP son los mismos que arriba más:

| Tecla | Acción |
|-------|--------|
| `gm` | Ir a implementación |
| `<leader>H` | Toggle inlay hints |
| `<leader>rn` | Renombrar símbolo |
| `<leader>ca` | Acciones de código |
| `<leader>e` | Ver diagnóstico en float |

### Rust — Cargo.toml (crates.nvim)

| Tecla | Acción |
|-------|--------|
| `<leader>cv` | Ver versiones del crate |
| `<leader>cf` | Ver features del crate |
| `<leader>cu` | Actualizar crate |
| `<leader>cU` | Actualizar todos los crates |

---

## Efectos / Diversión

| Tecla | Acción |
|-------|--------|
| `<leader>fm` | Animación "make it rain" |
| `<leader>wv` | Animación Game of Life |
| `<leader>da` | Invocar angry bees |
| `<leader>ds` | Invocar lions |
| `<leader>dk` | Eliminar animales |

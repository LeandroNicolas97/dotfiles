# Neovim — Keybindings y Comandos

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

## Buffers / Pestañas (Barbar)

| Tecla | Acción |
|-------|--------|
| `Tab+1` … `Tab+9` | Ir al buffer 1-9 |
| `Tab+0` | Ir al último buffer |
| `Tab+Tab` | Buffer siguiente |
| `Shift+Tab` | Buffer anterior |
| `<leader>q` | Cerrar buffer actual |

**Comandos:**
```
:BufferNext         buffer siguiente
:BufferPrevious     buffer anterior
:BufferGoto N       ir al buffer N
:BufferLast         último buffer
:BufferClose        cerrar buffer
```

---

## Terminal

| Tecla | Acción |
|-------|--------|
| `<leader>t` | Abrir terminal |
| `Ctrl+w` | Salir del modo terminal y navegar ventanas |

---

## Explorador de archivos (Neo-tree)

| Tecla | Acción |
|-------|--------|
| `Ctrl+n` | Abrir/cerrar explorador |
| `<leader>f` | Enfocar Neo-tree |
| `Enter` / `o` | Abrir archivo |
| `O` | Abrir con selector de ventana |

**Comandos:**
```
:Neotree            abrir explorador
:Neotree reveal     revelar archivo actual en el árbol
:Neotree close      cerrar explorador
```

---

## Harpoon (marcadores rápidos)

| Tecla | Acción |
|-------|--------|
| `<leader>a` | Agregar archivo actual |
| `Ctrl+e` | Abrir menú de Harpoon |
| `<leader>1` … `<leader>6` | Ir al archivo marcado 1-6 |

---

## Búsqueda — Telescope

| Tecla | Acción |
|-------|--------|
| `<leader>ff` | Buscar archivos (incluye ocultos) |
| `<leader>fg` | Live grep en el proyecto |
| `<leader>gg` | Buscar palabra bajo el cursor |
| `Ctrl+s` | Buscar archivos |
| `Ctrl+g` | Live grep |

**Dentro de Telescope:**

| Tecla | Acción |
|-------|--------|
| `Ctrl+j` | Bajar en la lista |
| `Ctrl+k` | Subir en la lista |
| `Ctrl+↓` | Scroll preview abajo |
| `Ctrl+↑` | Scroll preview arriba |
| `Ctrl+Space` | Toggle preview |

---

## Búsqueda — FZF

**Comandos:**
```
:ToggleHiddenSearch     toggle búsqueda de archivos ocultos
```

---

## LSP — Navegación de código

| Tecla | Acción |
|-------|--------|
| `gd` | Ir a definición |
| `gD` | Ir a declaración |
| `Ctrl+]` | Ir a definición (alternativo) |
| `gi` | Ir a implementación |
| `gr` | Ver referencias |
| `K` | Documentación hover |
| `Ctrl+k` | Firma de función |
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
| `<space>f` | Formatear archivo (LSP) |
| `<leader>kk` | Formatear archivo o selección |
| `<space>wa` | Agregar carpeta al workspace |
| `<space>wr` | Quitar carpeta del workspace |
| `<space>wl` | Listar carpetas del workspace |

**Comandos:**
```
:Format             formatear archivo actual
:MasonUpdate        actualizar servidores LSP instalados
:Mason              abrir gestor de servidores LSP
:TSUpdate           actualizar parsers de Treesitter
```

**Servidores LSP instalados:** Lua, TypeScript, Python (Pyright), HTML, CSS, JSON, C/C++ (Clangd)

## Diagnósticos

| Tecla | Acción |
|-------|--------|
| `<leader>dd` | Toggle todos los diagnósticos |
| `<leader>dw` | Toggle warnings (mantiene errores) |

---

## Autocompletado (cmp)

| Tecla | Acción |
|-------|--------|
| `Ctrl+Space` | Activar completado |
| `Tab` | Siguiente sugerencia |
| `Shift+Tab` | Sugerencia anterior |
| `Enter` | Confirmar selección |
| `Ctrl+e` | Cerrar completado |
| `Ctrl+b` | Scroll documentación arriba |
| `Ctrl+f` | Scroll documentación abajo |

**Fuentes activas:** LSP, Snippets (LuaSnip), Buffer, Path

---

## Git — Diffview

| Tecla / Comando | Acción |
|-----------------|--------|
| `:DiffviewOpen` | Ver diff de todos los cambios |
| `:DiffviewClose` | Cerrar Diffview |
| `:DiffviewFileHistory` | Ver historial de un archivo |
| `:DiffviewToggleFiles` | Toggle panel de archivos |
| `:DiffviewFocusFiles` | Enfocar panel de archivos |
| `]c` | Siguiente cambio |
| `[c` | Cambio anterior |

## Git — Fugitive y LazyGit

| Tecla | Acción |
|-------|--------|
| `<leader>gs` | Git status (Fugitive) |
| `<leader>gb` | Git branches |
| `<leader>gl` | Abrir LazyGit |

**Comandos:**
```
:Git                git status interactivo
:Git branch         ver ramas
:LazyGit            abrir LazyGit
:GitBlameToggle     toggle blame en línea actual
:GitBlameEnable     activar blame global
```

---

## Comentarios

| Tecla | Acción |
|-------|--------|
| `gc` | Toggle comentario (normal y visual) |
| `gcA` | Agregar comentario al final de línea |

---

## Copiar / Pegar

| Tecla | Acción |
|-------|--------|
| `Ctrl+c` | Copiar selección al clipboard (visual) |
| `Ctrl+v` | Pegar desde clipboard |

## Buscar y reemplazar

| Tecla | Acción |
|-------|--------|
| `<leader>p` | Reemplazar palabra bajo el cursor (con confirmación) |

---

## Markdown

| Tecla | Acción |
|-------|--------|
| `Ctrl+p` | Toggle preview en el navegador |
| `<leader>md` | Diagnóstico de markdown |

**Comandos:**
```
:MarkdownPreview        abrir preview
:MarkdownPreviewStop    cerrar preview
:MarkdownPreviewToggle  toggle preview
```

> Abre en Brave Browser por defecto en el puerto 8888.

---

## Lenguajes específicos

### Rust (rustaceanvim)

> Los keymaps de LSP son los mismos que los de arriba, más los siguientes:

| Tecla | Acción |
|-------|--------|
| `gm` | Ir a implementación |
| `<leader>H` | Toggle inlay hints |
| `<leader>rn` | Renombrar símbolo |
| `<leader>ca` | Acciones de código |
| `<leader>e` | Ver diagnóstico en float |

### Rust — Cargo.toml (crates.nvim)

> Solo activos cuando el archivo abierto es `Cargo.toml`

| Tecla | Acción |
|-------|--------|
| `<leader>cv` | Ver versiones disponibles del crate |
| `<leader>cf` | Ver features del crate |
| `<leader>cu` | Actualizar crate bajo el cursor |
| `<leader>cU` | Actualizar todos los crates |

### C / C++ (Clangd)

Usa los keymaps de LSP estándar. Formatter: `clang-format`.

### Python (Pyright)

Usa los keymaps de LSP estándar.

### TypeScript / JavaScript

Usa los keymaps de LSP estándar.

### HTML / CSS / JSON

Usa los keymaps de LSP estándar.

**Lenguajes con sintaxis (Treesitter):** Python, Lua, Rust, TOML, C, C++, JavaScript, TypeScript, CMake, YAML, Markdown, JSON, HTML, CSS

---

## Selector de ventana

| Tecla | Acción |
|-------|--------|
| `<leader>w` | Abrir selector de ventana |

---

## Efectos visuales / Diversión

| Tecla | Acción |
|-------|--------|
| `<leader>fm` | Animación "make it rain" |
| `<leader>wv` | Animación Game of Life |
| `<leader>da` | Invocar angry bees 🍺 |
| `<leader>ds` | Invocar lions 🤬 |
| `<leader>dd` | Invocar dragons 💜 |
| `<leader>dk` | Eliminar animales |

---

## Keywords resaltados automáticamente (todo-comments)

Los siguientes comentarios se resaltan con colores e íconos automáticamente:

```
TODO   FIXME   BUG    HACK   WARN   WARNING
NOTE   INFO    PERF   TEST   PASSED FAILED
```

Ejemplo:
```lua
-- TODO: implementar esto
-- FIXME: revisar este bug
-- NOTE: importante tener en cuenta
```

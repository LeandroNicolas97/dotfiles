return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    build = function()
      -- Verificar que node y npm estén disponibles
      if vim.fn.executable('node') == 0 then
        vim.notify("Node.js no está instalado. Por favor instala Node.js >= 12", vim.log.levels.ERROR)
        return
      end
      if vim.fn.executable('npm') == 0 then
        vim.notify("npm no está instalado. Por favor instala npm", vim.log.levels.ERROR)
        return
      end
      -- Instalar dependencias
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      -- CONFIGURACIÓN PARA BRAVE BROWSER
      -- Detectar Brave según el sistema operativo
      local brave_path = nil

      if vim.fn.has('mac') == 1 then
        -- macOS
        brave_path = '/Applications/Brave Browser.app/Contents/MacOS/Brave Browser'
      elseif vim.fn.has('win32') == 1 then
        -- Windows
        brave_path = 'C:\\Program Files\\BraveSoftware\\Brave-Browser\\Application\\brave.exe'
      else
        -- Linux - intentar diferentes ubicaciones comunes
        local linux_paths = {
          '/usr/bin/brave-browser',
          '/usr/bin/brave',
          '/snap/bin/brave',
          '/var/lib/flatpak/exports/bin/com.brave.Browser'
        }
        for _, path in ipairs(linux_paths) do
          if vim.fn.executable(path) == 1 then
            brave_path = path
            break
          end
        end
      end

      -- Configurar Brave si se encuentra
      if brave_path and vim.fn.executable(brave_path) == 1 then
        vim.g.mkdp_browser = '/usr/bin/brave'
        vim.notify("✅ Brave Browser configurado correctamente", vim.log.levels.INFO)
      else
        -- Fallback a navegadores alternativos
        local browsers = { 'firefox', 'google-chrome', 'chromium-browser', 'microsoft-edge' }
        local browser_found = nil
        for _, browser in ipairs(browsers) do
          if vim.fn.executable(browser) == 1 then
            browser_found = browser
            break
          end
        end
        if browser_found then
          vim.g.mkdp_browser = browser_found
          vim.notify("⚠️ Brave no encontrado. Usando: " .. browser_found, vim.log.levels.WARN)
        else
          vim.notify("❌ No se encontró ningún navegador compatible", vim.log.levels.ERROR)
        end
      end

      -- Configuración principal
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = '127.0.0.1'
      vim.g.mkdp_port = '8888'
      vim.g.mkdp_echo_preview_url = 1

      -- Configuración de tema y opciones de vista previa
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = 'middle',
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {}
      }

      -- CSS personalizado (opcional)
      vim.g.mkdp_markdown_css = ''
      vim.g.mkdp_highlight_css = ''

      -- Función mejorada para alternar vista previa
      local function toggle_markdown_preview()
        if vim.bo.filetype ~= 'markdown' then
          vim.notify("Este comando solo funciona en archivos markdown", vim.log.levels.WARN)
          return
        end

        -- Alternar vista previa (no es necesario guardar antes)
        vim.cmd('MarkdownPreviewToggle')

        -- Dar feedback al usuario
        vim.defer_fn(function()
          vim.notify("🚀 Vista previa en Brave (puerto " .. vim.g.mkdp_port .. ")", vim.log.levels.INFO)
        end, 500)
      end

      -- Función para diagnóstico
      local function diagnose_markdown_preview()
        local issues = {}

        -- Verificar Node.js
        if vim.fn.executable('node') == 0 then
          table.insert(issues, "❌ Node.js no está instalado")
        else
          local node_version = vim.fn.system('node --version'):gsub('\n', '')
          table.insert(issues, "✅ Node.js: " .. node_version)
        end

        -- Verificar npm
        if vim.fn.executable('npm') == 0 then
          table.insert(issues, "❌ npm no está instalado")
        else
          local npm_version = vim.fn.system('npm --version'):gsub('\n', '')
          table.insert(issues, "✅ npm: " .. npm_version)
        end

        -- Verificar navegador
        if vim.g.mkdp_browser then
          table.insert(issues, "✅ Navegador: " .. vim.g.mkdp_browser)
        else
          table.insert(issues, "❌ No se configuró ningún navegador")
        end

        -- Verificar puerto
        table.insert(issues, "ℹ️  Puerto configurado: " .. vim.g.mkdp_port)

        -- Mostrar diagnóstico
        vim.notify(table.concat(issues, '\n'), vim.log.levels.INFO)
      end

      -- Mapeos de teclado
      vim.keymap.set('n', '<C-p>', toggle_markdown_preview,
        { silent = true, desc = "Alternar vista previa de Markdown" })

      vim.keymap.set('n', '<leader>md', diagnose_markdown_preview,
        { silent = true, desc = "Diagnóstico de Markdown Preview" })

      -- Comando personalizado para diagnóstico
      vim.api.nvim_create_user_command('MarkdownDiagnose', diagnose_markdown_preview, {})
    end,
    ft = { "markdown" }
  }
}

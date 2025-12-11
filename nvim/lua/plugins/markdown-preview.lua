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
      -- Configuración del navegador (intenta detectar automáticamente)
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
      else
        vim.notify("No se encontró navegador compatible. Instala Firefox o Chrome.", vim.log.levels.WARN)
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

        -- Verificar si el archivo está guardado
        if vim.bo.modified then
          vim.notify("Guarda el archivo antes de abrir la vista previa", vim.log.levels.INFO)
          return
        end

        -- Alternar vista previa
        vim.cmd('MarkdownPreviewToggle')

        -- Dar feedback al usuario
        if vim.g.mkdp_preview_active == 1 then
          vim.notify("Vista previa abierta en " .. vim.g.mkdp_browser .. " en puerto " .. vim.g.mkdp_port, vim.log.levels.INFO)
        else
          vim.notify("Vista previa cerrada", vim.log.levels.INFO)
        end
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
          table.insert(issues, "❌ No se encontró navegador compatible")
        end

        -- Verificar puerto
        local port_check = vim.fn.system('netstat -tuln | grep :' .. vim.g.mkdp_port)
        if port_check ~= '' then
          table.insert(issues, "⚠️  Puerto " .. vim.g.mkdp_port .. " puede estar en uso")
        else
          table.insert(issues, "✅ Puerto " .. vim.g.mkdp_port .. " disponible")
        end

        -- Mostrar diagnóstico
        vim.notify("Diagnóstico de Markdown Preview:\n" .. table.concat(issues, '\n'), vim.log.levels.INFO)
      end

      -- Mapeos de teclado
      vim.keymap.set('n', '<C-l>', toggle_markdown_preview,
        { silent = true, desc = "Alternar vista previa de Markdown" })

      vim.keymap.set('n', '<leader>md', diagnose_markdown_preview,
        { silent = true, desc = "Diagnóstico de Markdown Preview" })

      -- Comando personalizado para diagnóstico
      vim.api.nvim_create_user_command('MarkdownDiagnose', diagnose_markdown_preview, {})
    end,
    ft = { "markdown" }
  }
}

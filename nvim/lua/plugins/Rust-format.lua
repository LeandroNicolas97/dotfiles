return {
  'mrcjkb/rustaceanvim',
  version = '^5',
  lazy = false,
  config = function()
    vim.g.rustaceanvim = {
      server = {
        on_attach = function(client, bufnr)
          vim.keymap.set("n", "gf", vim.lsp.buf.definition, { buffer = bufnr, desc = "Rust Go to Definition" })
          vim.keymap.set("n", "l", vim.lsp.buf.hover, { buffer = bufnr, desc = "Rust Hover Actions" })
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end,
        default_settings = {
          ['rust-analyzer'] = {
            checkOnSave = true,
            check = {
              command = "clippy",
            },
            procMacro = {
              enable = true,
            },
          },
        },
      },
    }
  end,
}

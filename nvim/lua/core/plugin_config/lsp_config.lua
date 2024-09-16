require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls" }
}

require('mason-tool-installer').setup {
  ensure_installed = {
    "black",
  },
  auto_update = true,
  run_on_start = true
}

local on_attach = function(client, bufnr)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})

  if client.server_capabilities.document_formatting then
    vim.cmd([[
      augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ bufnr = bufnr })
      augroup END
    ]])
  end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").lua_ls.setup {
 on_attach = on_attach,
 capabilities = capabilities
}

require("lspconfig").pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

local none_ls = require("null-ls")
local formatting = none_ls.builtins.formatting

none_ls.setup({
  sources = {
    formatting.black.with({
      command = "black",
      args = { "--quiet", "-" }
    }),
  },
  on_attach = on_attach
})

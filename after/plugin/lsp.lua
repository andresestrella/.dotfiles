local lsp = require("lsp-zero")

lsp.preset({
    name="recommended",
    set_lsp_keypmaps = true,
    suggest_lsp_servers = false,
    manage_nvim_cmp = true,
})

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
  'eslint',
  'lua_ls',
  'tailwindcss',
})


--local nvim_lsp = require('lspconfig')
--nvim_lsp.tailwindcss.setup{}
--nvim_lsp.tsserver.setup{}


--comment this out to enable eslint
lsp.on_attach(function(client, bufnr)
    if client.name == "eslint" then
      vim.cmd [[ LspStop eslint ]]
      return
    end
  local opts = {buffer = bufnr, remap = false}




local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-S-J>'] = cmp.mapping.confirm({ select = true }),
    --['<CR>'] = cmp.mapping.confirm({ select = false }),
})


--disable autocompletion for tab and shift-tab
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil
--cmp_mappings['<CR>'] = nil

--lets me use enter freely
lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  preselect = 'none',
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect'
  },
})
lsp.setup()

-- lsp.set_preferences({
--     suggest_lsp_servers = false,
--     sign_icons = {
--         error = 'E',--
--         warn = 'W',--
--         hint = 'H',--󰞋
--         info = 'I'--
--     }
-- })

-- local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
-- for type, icon in pairs(signs) do
--   local hl = "LspDiagnosticsSign" .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
-- end

local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " "
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  -- go to definition
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
  --see all references
  vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
  --maps K to show documentation
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', '<C-S-K>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "gl", function() vim.lsp.diagnostic.show_line_diagnostics() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  -- maps for diagnostics
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
 --rename all occurrences
  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
  --show signature help
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)



-- show diagnostics in virtual text
vim.diagnostic.config({
    virtual_text = true
})

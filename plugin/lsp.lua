local lsp_zero = require('lsp-zero')

-- lsp_attach is where you enable features that only work
-- if there is a language server active in the file
local lsp_attach = function(client, bufnr)
  local opts = {buffer = bufnr}

  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
  vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end

lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

local lsp_configs = {
	basedpyright = { settings = { basedpyright = {
		analysis = {autoImportCompletions = false, typeCheckingMode = 'standard' },
	}}},
}


require("mason").setup()
require('mason-lspconfig').setup({
  -- Replace the language servers listed here 
  -- with the ones you want to install
  ensure_installed = {'basedpyright'},
  handlers = {
    function(server_name)
      local lsp_config = lsp_configs[server_name]
      if lsp_config == nil then lsp_config = {} end
      require('lspconfig')[server_name].setup(lsp_config)
    end,
  },
})

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  sources = {
    -- Add other sources if needed
    { name = 'nvim_lsp', keyword_length = 2},
    { name = 'vimtex', keyword_length = 2},
  },
  snippet = {
    expand = function(args)
     luasnip.lsp_expand(args.body)
    end,
  },
  window = {
	  completion = cmp.config.window.bordered(),
	  documentation= cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
	 ['<CR>'] = cmp.mapping(function(fallback)
        if luasnip.expandable() then
        	luasnip.expand()
		elseif cmp.visible() then
            cmp.confirm({
                select = true,
            })
        else
            fallback()
        end
    end),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }), 
   ["<C-e>"] = cmp.mapping.abort(),         -- Close completion menu
  }),
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

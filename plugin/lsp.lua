-- Install LSPs
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {'lua_ls', 'basedpyright'},
	automatic_enable = false,
})

-- Setup LSPs
vim.lsp.config('luals', {
  cmd = {'lua-language-server'},
  filetypes = {'lua'},
  root_markers = {'.luarc.json', '.luarc.jsonc'},
})

vim.lsp.enable('luals')

vim.lsp.config('bpyright', {
	cmd = {'basedpyright-langserver', '--stdio'},
	filetypes = {'python'},
	root_markers = {'.git'},
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "basic",
				autoImportCompletions= false,
				--reportUnknownMemberType = "none",
			},
		}
	}
})

vim.lsp.enable('bpyright')

vim.lsp.config('clang', {
	cmd = {'clangd'},
	filetypes= {'c', 'cpp'},
})
vim.lsp.enable('clang')


-- Diagnostic should have rounded borders
vim.o.winborder = 'rounded'

-- Autocomplete maps
vim.api.nvim_set_keymap(
  'n', '<Leader>d', ':lua vim.diagnostic.open_float()<CR>',
  { noremap = true, silent = true}
)


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
			return
		elseif cmp.visible() then
            cmp.confirm({
                select = false,
            })
        end
        fallback()
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

local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then return end

local snip_status_ok, luasnip = pcall(require, 'luasnip')
if not snip_status_ok then return end

require('luasnip.loaders.from_vscode').lazy_load()



local has_words_before = function()
  	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_kinds = {
  	Text = '  ', -- Text
  	Method = '  ', -- Method
  	Function = '  ', -- Function
  	Constructor = '  ', -- Constructor
  	Field = '  ', -- Field
  	Variable = '  ', -- Variable
  	Class = '  ', -- Class
  	Interface = 'ﰮ  ', -- Interface
  	Module = '  ', -- Module
  	Property = '  ', -- Property
  	Unit = '  ', -- Unit
  	Value = '  ', -- Value
  	Enum = '  ', -- Enum
  	Keyword = '  ', -- Keyword
  	Snippet = '﬌  ', -- Snippet
  	Color = '  ', -- Color
  	File = '  ', -- File
  	Reference = '  ', -- Reference
  	Folder = '  ', -- Folder
  	EnumMember = '  ', -- EnumMember
  	Constant = '  ', -- Constant
  	Struct = '  ', -- Struct
  	Event = '  ', -- Event
  	Operator = 'ﬦ  ', -- Operator
	TypeParameter = '  ', -- TypeParameter
}
cmp.setup({
	snippet = {
    	expand = function(args)
      		luasnip.lsp_expand(args.body)
    	end,
  	},
	window = {
    	completion = cmp.config.window.bordered(),
    	documentation = cmp.config.window.bordered(),
    },
	mapping = {
		['J'] = cmp.mapping.scroll_docs(-4),
      	['K'] = cmp.mapping.scroll_docs(4),
      	['<C-Space>'] = cmp.mapping.complete(),
      	['<C-e>'] = cmp.mapping.abort(),
      	['<CR>'] = cmp.mapping.confirm({ select = true }),

    	["<Tab>"] = cmp.mapping(function(fallback)
      		if cmp.visible() then
        		cmp.select_next_item()
      		elseif luasnip.expand_or_jumpable() then
        		luasnip.expand_or_jump()
      		elseif has_words_before() then
        		cmp.complete()
      		else
        		fallback()
      		end
    	end, { "i", "s" }),

    	["<S-Tab>"] = cmp.mapping(function(fallback)
      		if cmp.visible() then
        		cmp.select_prev_item()
      		elseif luasnip.jumpable(-1) then
        		luasnip.jump(-1)
      		else
        		fallback()
      		end
    	end, { "i", "s" }),

	},

	formatting = {
    	fields = { "menu", "abbr", "kind" },
    	format = function(entry, vim_item)
      		vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
			vim_item.menu = ({
				nvim_lsp = 'L',
				luasnip = 'S',
				buffer = 'B',
				path = 'P'
			})[entry.source.name]
      		return vim_item
    	end,
  	},

	sources = cmp.config.sources({
      	{ name = 'nvim_lsp' },
      	{ name = 'luasnip' }, -- For luasnip users.
    	{ name = 'buffer' },
		{ name = 'path' }
	}),

	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false
	},

	experimental = {
    	ghost_text = false,
    	native_menu = false,
  	},

	enabled = function()
      	-- disable completion in comments
      	local context = require 'cmp.config.context'
      	-- keep command mode completion enabled when cursor is in a comment
      	if vim.api.nvim_get_mode().mode == 'c' then
        	return true
      	else
        	return not context.in_treesitter_capture("comment") 
          	and not context.in_syntax_group("Comment")
      	end
    end

})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
    	{ name = 'path' }
    }, {
    	{ name = 'cmdline' }
	})
})


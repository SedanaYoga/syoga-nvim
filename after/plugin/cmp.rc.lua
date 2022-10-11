--[[ local status, cmp = pcall(require, "cmp")
if not status then
	return
end ]]

local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- for `luasnip` user
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = {
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

		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},
	enabled = function()
		-- disable in telescope
		local buftype = vim.api.nvim_buf_get_option(0, "buftype")
		if buftype == "prompt" then
			return false
		end

		-- disable completion in comments
		local context = require("cmp.config.context")

		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,

	sources = cmp.config.sources({
		{ name = "luasnip", max_item_count = 5 },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "buffer", keyword_length = 4 },
		{ name = "path", max_item_count = 5 },
		-- { name = "cmdline", keyword_length = 2, max_item_count = 5 },
		{ name = "emoji", max_item_count = 5 },
		{ name = "cmp_tabnine", keyword_length = 5, max_item_count = 5 },
	}, {
		name = "buffer",
	}),
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = lspkind.cmp_format({
			mode = "symbol_text",
			menu = {
				nvim_lsp = "[LSP]",
				nvim_lua = "[LUA]",
				luasnip = "[LUASNIP]",
				path = "[PATH]",
				emoji = "[EMOJI]",
				buffer = "[BUFF]",
				-- cmdline = "[CMD]",
				cmp_tabnine = "[TAB9]",
			},
			with_text = false,
			maxwidth = 50,
		}),
		--[[ format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				nvim_lua = "[NVIMLUA]",
				luasnip = "[Snippet]",
				path = "[Path]",
				emoji = "[Emoji]",
				buffer = "[Buffer]",
				cmdline = "[CMD]",
				cmp_tabnine = "[TAB9]",
			})[entry.source.name]
			return vim_item
		end, ]]
	},
})

--[[ cmp.setup.cmdline(":", {
	sources = {
		{ name = "cmdline" },
	},
})

cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
}) ]]

--[[ cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
}) ]]

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
require("lspconfig")["tsserver"].setup({
	capabilities = capabilities,
})

vim.cmd([[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]])

-- " Use <Tab> and <S-Tab> to navigate through popup menu
-- inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
-- inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

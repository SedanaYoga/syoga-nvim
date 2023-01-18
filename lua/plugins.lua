local status, packer = pcall(require, "packer")
if not status then
	print("Packer is not installed")
	return
end

vim.cmd([[packadd packer.nvim]])

packer.startup(function(use)
	use("wbthomason/packer.nvim")
	--[[ use {
    'svrana/neosolarized.nvim',
    requires = { 'tjdevries/colorbuddy.nvim' }
  } ]]
	use("nvim-lualine/lualine.nvim") -- Statusline
	use("nvim-lua/plenary.nvim") -- Common utilities
	use("onsails/lspkind-nvim") -- vscode-like pictograms

	-- Completion
	use({
		"hrsh7th/nvim-cmp",
		commit = "203aa26fc2628ca285cc143685648ec45675bc8a",
	}) -- Completion
	use("hrsh7th/cmp-buffer") -- nvim-cmp source for buffer words
	use("hrsh7th/cmp-path") -- nvim-cmp source for buffer words
	use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for neovim's built-in LSP
	use("hrsh7th/cmp-nvim-lua") -- Completion
	use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" }) -- our lovely tabnine
	use({ "hrsh7th/cmp-emoji" }) -- our lovely tabnine

	-- Completion.snippets
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	use("neovim/nvim-lspconfig") -- LSP
	use("jose-elias-alvarez/null-ls.nvim") -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
	use("MunifTanjim/prettier.nvim") -- Prettier plugin for Neovim's built-in LSP client
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- Colorscheme
	use("folke/tokyonight.nvim")
	use("tiagovla/tokyodark.nvim")
	use("EdenEast/nightfox.nvim")
	use("glepnir/lspsaga.nvim") -- LSP UIs
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})

	-- Dashboard
	use({ "glepnir/dashboard-nvim" })

	-- Nvim Ultra Fold
	use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })

	-- FILE FINDER
	use("kyazdani42/nvim-web-devicons") -- File icons
	use("kyazdani42/nvim-tree.lua") -- Tree like file browser
	use("nvim-telescope/telescope.nvim") -- Fuzzy finder

	use("windwp/nvim-autopairs") -- autopair bracket
	use("windwp/nvim-ts-autotag") -- autotag html

	use("norcalli/nvim-colorizer.lua")
	-- use("mrshmllow/document-color.nvim")

	use("akinsho/nvim-bufferline.lua")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("numToStr/Comment.nvim")

	use("lewis6991/gitsigns.nvim")
	use("dinhhuy258/git.nvim") -- For git blame & browse
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	})
end)

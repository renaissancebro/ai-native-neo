local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- This is where put setup call
require("lazy").setup({

	-- Theme
	{
		"scottmckendry/cyberdream.nvim",
		priority = 1000,
		config = function()
			require("cyberdream").setup({
				transparent = false,
				italic_comments = true,
				hide_fillchars = true,
				borderless_telescope = true,
			})
			vim.cmd.colorscheme("cyberdream")
		end,
	},

	-- UI
	{ "nvim-lualine/lualine.nvim" },
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- Syntax
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	-- Navigation
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup()
		end,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").pyright.setup({}) -- Python
			require("lspconfig").vtsls.setup({}) -- JavaScript/TypeScript
		end,
	},

	-- LSP
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({}),
				sources = { { name = "nvim_lsp" } },
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
				formatters_by_ft = {
					python = { "black" },
					javascript = { "prettier" },
					lua = { "stylua" },
				},
			})
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({}),
				sources = { { name = "nvim_lsp" } },
			})
		end,
	},
})

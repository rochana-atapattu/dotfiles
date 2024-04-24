local formatters = {
	javascript = { "prettier" },
	javascriptreact = { "prettier" },
	typescript = { "prettier" },
	typescriptreact = { "prettier" },
	json = { "prettier" },
	jsonc = { "prettier" },
	html = { "prettier" },
	yaml = { "prettier" },
	css = { "stylelint", "prettier" },
	sh = { "shellcheck", "shfmt" },
	lua = { "stylua" },
	go = { "goimports", "gofmt" },
	templ = { "templ" },
	terraform = { "terraform_fmt" },
	rego = { "opa_fmt" },
}

return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			-- Helpers to install LSPs and maintain them
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
		},
		config = function()
			require("plugins.lsp.config").setup()
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					svelte = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					graphql = { "prettier" },
					lua = { "stylua" },
					python = { "isort", "black" },
					go = { "goimports", "gofmt" },
					templ = { "templ" },
					terraform = { "terraform_fmt" },
					rego = { "opa_fmt" },
					java = { "google-java-format" },
				},
			})

			local nnoremap = require("utils").nnoremap
			nnoremap("<leader>f", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format file or range (in visual mode)" })
		end,
	},

	{
		"folke/trouble.nvim",
		config = true,
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle<cr>" },
			{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>" },
			{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>" },
			{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>" },
			{ "<leader>xl", "<cmd>TroubleToggle loclist<cr>" },
		},
	},
	-- {
	-- 	"jay-babu/mason-null-ls.nvim",
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	dependencies = {
	-- 		"williamboman/mason.nvim",
	-- 	},
	-- 	config = function()
	-- 		require("mason-null-ls").setup({
	-- 			ensure_installed = {
	-- 			"stylua",
	-- 			"jq",
	-- 			"google-java-format",
	-- 			}
	-- 		})
	-- 	end,
	-- },
}

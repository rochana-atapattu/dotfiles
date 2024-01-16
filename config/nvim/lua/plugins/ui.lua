local theme = require("theme")
local icons = theme.icons

local is_dark = require("utils").is_dark_mode()

return {
	-- fast colorizer for showing hex colors
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			filetypes = { "*" },
			user_default_options = {
				mode = "background",
				tailwind = true,
				RGB = true,
				RRGGBB = true,
				names = true,
				RRGGBBAA = true,
				rgb_fn = true,
				hsl_fn = true,
				css = true,
				css_fn = true,
			},
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
			routes = {
				{
					filter = { find = "No information available" },
					opts = { stop = true },
				},
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				section_separators = { right = "", left = "" },
				component_separators = "", --{ right = "", left = "" },
			},
			sections = {
				lualine_a = {
					{ "mode" },
					{
						"macro-recording",
						fmt = function()
							local recording_register = vim.fn.reg_recording()
							if recording_register == "" then
								return ""
							else
								return "Recording @" .. recording_register
							end
						end,
					},
				},
				lualine_b = {
					"branch",
					{ "diff", symbols = { added = " ", modified = " ", removed = "󰮉 " } },
					"diagnostics",
				},
				lualine_c = { "filename", "searchcount" },
				lualine_x = { "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		},
		config = function(_, opts)
			local lualine = require("lualine")
			lualine.setup(opts)
			vim.api.nvim_create_autocmd("RecordingEnter", {
				callback = function()
					-- refresh lualine when entering record mode
					lualine.refresh({ place = { "lualine_a" } })
				end,
			})
		end,
	},

	-- Floating statuslines. This is used to shwo buffer names in splits
	{ "b0o/incline.nvim", opts = { hide = { cursorline = false, focused_win = false, only_win = true } } },

	-- Show git diff in sign column
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { hl = "GitSignsAdd", text = "┃", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
				change = {
					hl = "GitSignsChange",
					text = "┃",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
				delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
				topdelete = {
					hl = "GitSignsDelete",
					text = "‾",
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				changedelete = {
					hl = "GitSignsChange",
					text = "~",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
			},
			numhl = false,
			linehl = false,
			-- keymaps = {
			--   -- Default keymap options
			--   noremap = true,
			--   ["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
			--   ["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },
			--   ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
			--   ["v <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
			--   ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
			--   ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
			--   ["v <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
			--   ["n <leader>hR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
			--   ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
			--   ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
			--   -- Text objects
			--   ["o ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
			--   ["x ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
			-- },
			watch_gitdir = { interval = 1000, follow_files = true },
			current_line_blame_opts = { delay = 1000, virtual_text_pos = "eol" },
			current_line_blame = false,
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			word_diff = false,
			diff_opts = { internal = true },
		},
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			style = is_dark and "storm" or "day", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
			light_style = "day", -- The theme is used when the background is set to light
			transparent = true, -- Enable this to disable setting the background color
			terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
			styles = {
				-- Style to be applied to different syntax groups
				-- Value is any valid attr-list value for `:help nvim_set_hl`
				comments = { italic = true },
				keywords = { italic = true },
				functions = {},
				variables = {},
				-- Background styles. Can be "dark", "transparent" or "normal"
				sidebars = "dark", -- style for sidebars, see below
				floats = "dark", -- style for floating windows
			},
			sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
			day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
			hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
			dim_inactive = false, -- dims inactive windows
			lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
		},
	},

	-- everforest theme
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				transparent_background_level = 2,
			})
		end,
	},

	-- Catppuccin theme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		opts = {
			flavour = require("utils").is_dark_mode() and "mocha" or "latte",
			dim_inactive = { enabled = false, shade = "dark", percentage = 0.15 },
			transparent_background = true,
			term_colors = true,
			compile = { enabled = true, path = vim.fn.stdpath("cache") .. "/catppuccin", suffix = "_compiled" },
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				loops = {},
				functions = { "bold" },
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			integrations = {
				treesitter = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
				},
				lsp_trouble = false,
				cmp = true,
				gitsigns = true,
				telescope = true,
				markdown = true,
				ts_rainbow = true,
			},
		},
	},

	-- Prettier notifications
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss all Notifications",
			},
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			background_colour = "#1e222a",
			render = "minimal",
		},
		init = function()
			local banned_messages = { "No information available" }
			vim.notify = function(msg, ...)
				for _, banned in ipairs(banned_messages) do
					if msg == banned then
						return
					end
				end
				return require("notify")(msg, ...)
			end
		end,
	},
	-- Make folds look Prettier
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		opts = {
			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = ("   %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0

				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end

				table.insert(newVirtText, { suffix, "MoreMsg" })

				return newVirtText
			end,
			close_fold_kinds = { "imports" },
		},
	},
}

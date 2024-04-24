return {
	"ThePrimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		-- set keymaps
		local keymap = vim.keymap -- for conciseness
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		keymap.set("n", "<leader>h", ui.toggle_quick_menu)
		keymap.set("n", "<C-h>", mark.add_file)

		keymap.set("n", "<C-h>h", function()
			ui.nav_next()
		end)
		keymap.set("n", "<C-h>l", function()
			ui.nav_prev()
		end)
	end,
}

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

		keymap.set("n", "<leader>h", mark.add_file)
		keymap.set("n", "<C-h>", ui.toggle_quick_menu)

		keymap.set("n", "<C-h>h", function()
			ui.nav_file(1)
		end)
		keymap.set("n", "<C-h>j", function()
			ui.nav_file(2)
		end)
		keymap.set("n", "<C-h>k", function()
			ui.nav_file(3)
		end)
		keymap.set("n", "<C-h>l", function()
			ui.nav_file(4)
		end)
	end,
}

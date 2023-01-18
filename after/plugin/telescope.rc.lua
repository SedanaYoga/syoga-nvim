local status, telescope = pcall(require, "telescope")
if not status then
	return
end
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		preview = {
			treesitter = false,
		},
		mappings = {
			n = {
				["q"] = actions.close,
				["l"] = actions.select_default,
				["<Leader>q"] = actions.send_selected_to_qflist + actions.open_qflist,
			},
		},
	},
	extensions = {},
})

vim.keymap.set("n", "<Leader>f", function()
	builtin.find_files({
		no_ignore = false,
		hidden = true,
	})
end)

vim.keymap.set("n", "<Leader>r", function()
	builtin.live_grep()
end)
vim.keymap.set("n", "\\\\", function()
	builtin.buffers()
end)
vim.keymap.set("n", "<Leader>t", function()
	builtin.help_tags()
end)
vim.keymap.set("n", ";;", function()
	builtin.resume()
end)
vim.keymap.set("n", ";e", function()
	builtin.diagnostics()
end)

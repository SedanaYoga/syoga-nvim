local keymap = vim.keymap

vim.g.mapleader = " "

-- Yank line down and up
keymap.set("n", "<Leader>j", "yypk<cr>")
keymap.set("n", "<Leader>k", "yyPj<cr>")
keymap.set("x", "<Leader>j", ":co '><CR>V'[=gv")
keymap.set("x", "<Leader>k", ":co '<-1<CR>V'[=gv")

-- Move text up and down
keymap.set("x", "J", ":move '>+1<CR>gv-gv")
keymap.set("x", "K", ":move '<-2<CR>gv-gv")

-- Stay in indent Mode
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Persist yanked text
keymap.set("v", "p", '"_dP')

-- Comment
vim.g.kommentary_create_default_mappings = false
vim.api.nvim_set_keymap("n", "<leader>/", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("n", "<leader>c", "<Plug>kommentary_motion_default", {})
vim.api.nvim_set_keymap("x", "<leader>/", "<Plug>kommentary_visual_default", {})

-- Do not yank with x
keymap.set("n", "x", '"_x')

-- No Highlights
keymap.set("n", "<Leader>h", "<cmd>nohlsearch<CR>")

-- Escape Insert Mode
keymap.set("i", "jj", "<Esc>")

-- Close Buffer
keymap.set("n", "<Leader>c", "<Cmd>bd<Cr>")

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab
keymap.set("n", "te", ":tabedit<Return>", { silent = true })

-- Split window
keymap.set("n", "ss", ":split<Return><C-w>w", { silent = true })
keymap.set("n", "sv", ":vsplit<Return><C-w>w", { silent = true })

-- Move window
-- keymap.set('n', '<Space>', '<C-w>w')
keymap.set("", "sh", "<C-w>h")
keymap.set("", "sk", "<C-w>k")
keymap.set("", "sj", "<C-w>j")
keymap.set("", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

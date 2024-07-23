vim.keymap.set("n",  "<leader>pv", vim.cmd.Ex)

-- Allows J/K in visual mode to move highlighted selection.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Makes searching stay in the middle of the page.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Makes <leader>p paste over highlighted selection without overwriting buffer.
-- S-eems useful, but overrides <leader>pv keybinding.
-- vim.keymap.set("x", "<leader>p", "\"_dP")

-- Makes <leader>y copy to system clipboard.
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Makes <leader>d delete to void register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

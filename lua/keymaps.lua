-- Paste without overwriting the default register
vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true })

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { noremap = true, silent = true })

-- LSP
vim.keymap.set("n", "<leader>lf", function()
  vim.lsp.buf.format({ async = false })
end, { noremap = true, silent = true, desc = "Format current buffer" })

vim.keymap.set({ "n", "v" }, "<leader>a", function()
  vim.lsp.buf.code_action()
end, { noremap = true, silent = true, desc = "LSP code actions" })

vim.keymap.set("n", "<leader>gd", function()
  vim.lsp.buf.definition()
end, { noremap = true, silent = true, desc = "Go to definition" })

vim.keymap.set("n", "<leader>gr", function()
  vim.lsp.buf.references()
end, { noremap = true, silent = true, desc = "Go to references" })

vim.keymap.set("n", "<leader>rn", function()
  vim.lsp.buf.rename()
end, { noremap = true, silent = true, desc = "LSP rename symbol" })

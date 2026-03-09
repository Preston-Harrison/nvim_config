return {
  "natecraddock/workspaces.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("workspaces").setup({ auto_open = true })
    require("telescope").load_extension("workspaces")
    vim.keymap.set("n", "<leader>w", "<cmd>Telescope workspaces<cr>", { desc = "Workspaces" })
  end,
}

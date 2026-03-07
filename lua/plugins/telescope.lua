return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>pf", function() require("telescope.builtin").find_files() end, desc = "Find files" },
    { "<leader>pg", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
    { "<leader>ps", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, desc = "Workspace symbols" },
  },
}

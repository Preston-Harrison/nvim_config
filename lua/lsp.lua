-- cmp-nvim-lsp extends the default client capabilities to advertise
-- completion support to all servers. Set once globally with '*'.
vim.lsp.config('*', {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- Go: gopls
-- Requires: brew install gopls  (or: go install golang.org/x/tools/gopls@latest)
vim.lsp.config('gopls', {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      gofumpt = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
})

-- Kotlin: kotlin-language-server
-- Requires: brew install kotlin-language-server
vim.lsp.config('kotlin_language_server', {
  root_markers = { "settings.gradle", "settings.gradle.kts", "build.gradle", "build.gradle.kts", ".git" },
  settings = {
    kotlin = {
      compiler = {
        jvm = { target = "17" },
      },
      completion = { snippets = { enabled = true } },
    },
  },
})

-- Java: see ftplugin/java.lua

-- TypeScript/JavaScript: ts_ls
-- Requires: npm install -g typescript-language-server typescript
vim.lsp.config('ts_ls', {
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
})

vim.lsp.enable({ 'gopls', 'kotlin_language_server', 'ts_ls' })

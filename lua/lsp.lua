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
  cmd = { 'kotlin-language-server' },
  filetypes = { "kotlin" },
  root_markers = { "settings.gradle", "settings.gradle.kts", "build.gradle", "build.gradle.kts", "pom.xml" },
  init_options = {
    -- Points the server's cache at the project root rather than the home directory.
    -- This gives each project its own isolated index and speeds up subsequent startups.
    storagePath = vim.fs.root(vim.fn.expand('%:p:h'), { "settings.gradle", "settings.gradle.kts", "build.gradle", "build.gradle.kts" }),
  },
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
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
  cmd = { "typescript-language-server", "--stdio" },
  settings = {
    implicitProjectConfiguration = {
      checkJs = true,
    },
  },
})

vim.lsp.enable({ 'gopls', 'kotlin_language_server', 'ts_ls' })

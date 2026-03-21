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
local kotlin_root_markers = {
  "settings.gradle",
  "settings.gradle.kts",
  "build.gradle",
  "build.gradle.kts",
  "pom.xml",
  "Config",  -- Brazil
}

-- Derive KOTLIN_HOME dynamically from PATH
local kotlin_bin = vim.fn.exepath('kotlin')
local kotlin_home = kotlin_bin ~= '' and vim.fn.fnamemodify(kotlin_bin, ':h:h') or nil

if not kotlin_home then
  vim.notify("kotlin not found on PATH, stdlib resolution may fail", vim.log.levels.WARN)
end

vim.lsp.config('kotlin_language_server', {
  cmd = { 'kotlin-language-server' },
  filetypes = { "kotlin" },
  root_markers = kotlin_root_markers,
  cmd_env = kotlin_home and { KOTLIN_HOME = kotlin_home } or {},
  init_options = {
    storagePath = vim.fs.root(vim.fn.expand('%:p:h'), kotlin_root_markers)
      or vim.fn.getcwd(),
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

-- Commands
vim.api.nvim_create_user_command("LspStop", function()
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    client.stop()
  end
end, {})

vim.api.nvim_create_user_command("LspStart", function()
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    vim.lsp.enable(client.name)
  end
end, {})

vim.api.nvim_create_user_command("LspRestart", function()
  local client_names = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    table.insert(client_names, client.name)
    client.stop()
  end
  vim.defer_fn(function()
    for _, name in ipairs(client_names) do
      vim.lsp.enable(name)
    end
  end, 500)
end, {})


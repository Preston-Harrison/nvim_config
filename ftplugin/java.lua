-- jdtls is configured here rather than lsp.lua because it needs a per-project
-- workspace directory evaluated at file-open time, not at startup.
-- ftplugin/java.lua runs automatically whenever a Java buffer is opened.
--
-- Requires: brew install jdtls
-- For non-standard build systems (e.g. Brazil), add classpath entries via:
--   settings = { java = { project = { referencedLibraries = { "/path/**/*.jar" } } } }
local root = vim.fs.root(0, { "pom.xml", "build.gradle", "build.gradle.kts", ".git" })
local project_name = root and vim.fn.fnamemodify(root, ":t") or "default"

vim.lsp.start({
  name = "jdtls",
  cmd = { "jdtls", "-data", vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. project_name },
  root_dir = root,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

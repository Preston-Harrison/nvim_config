# nvim config

Personal Neovim configuration.

## Structure

- `init.lua` — options and plugin manager bootstrap
- `lua/keymaps.lua` — keybindings
- `lua/lsp.lua` — LSP server configuration
- `ftplugin/` — filetype-specific LSP setup
- `lua/plugins/` — one file per plugin

## Plugins

Managed by [lazy.nvim](https://github.com/folke/lazy.nvim).

- Autocomplete via nvim-cmp
- Fuzzy finding via Telescope
- File marking via Harpoon
- Syntax highlighting via nvim-treesitter

## LSP

Uses Neovim 0.11's built-in `vim.lsp.config` / `vim.lsp.enable` API. No nvim-lspconfig.

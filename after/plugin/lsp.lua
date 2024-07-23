local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr }
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps(opts)
    vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set('n', '<leader>lf', function()
        if vim.bo.filetype == 'python' then
            vim.cmd('w')
            vim.cmd('silent !black %')
            vim.cmd('e')
        else
            vim.lsp.buf.format()
        end
    end, opts)
    vim.keymap.set('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end)

-- handles go templ
vim.filetype.add({
    extension = {
        templ = "templ",
    },
})

require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = { 'tsserver', 'rust_analyzer', 'lua_ls', 'pyright', 'ocamllsp', 'clangd', 'jdtls', 'gopls',
        'templ', 'csharp_ls', "html", 'tailwindcss' },
    handlers = {
        lsp_zero.default_setup,
    },
})

local cmp = require('cmp')

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    })
})

require 'lspconfig'.gdscript.setup {}

require 'lspconfig'.html.setup {
    filetypes = { "html", "handlebars" },
}

require 'lspconfig'.clangd.setup {
    filetypes = { "c", "cpp", "objc", "objcpp" },
}

require 'lspconfig'.rust_analyzer.setup {
    settings = {
        ["rust-analyzer"] = {
          diagnostics = {
              enable = true,
              disabled = {"unresolved-proc-macro"},
              enableExperimental = true,
          },
      }
  }
}

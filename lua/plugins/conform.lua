vim.pack.add({
    'https://github.com/stevearc/conform.nvim',
})

require('conform').setup({
    default_format_opts = {
        lsp_format = 'fallback',
    },
})

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
    require('conform').format({ async = true })
end, { desc = '[F]ormat Current File' })

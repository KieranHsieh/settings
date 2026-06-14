vim.pack.add({
    'https://github.com/stevearc/conform.nvim',
})

require('conform').setup({
    default_format_opts = {
        lsp_format = 'fallback',
    },
})

local function format_file()
    require('conform').format({ async = true })
end

vim.keymap.set({ 'n', 'v' }, '<leader>f', format_file, { desc = '[F]ormat Current File' })

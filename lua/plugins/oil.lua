vim.pack.add({
    'https://github.com/stevearc/oil.nvim',
})

require('oil').setup({
    default_file_explorer = true,
    float = {
        max_width = 0.7,
        max_height = 0.5,
        border = 'rounded',
        preview_split = 'right',
    },
    keymaps = {
        ['<ESC><ESC>'] = { 'actions.close' },
        ['<C-c>'] = false,
        ['<C-s>'] = false,
    },
})

local function open_cwd(opts)
    require('oil').open_float(vim.loop.cwd())
end

vim.keymap.set('n', '<leader>se', open_cwd, { desc = '[S]earch With File [E]xplorer' })

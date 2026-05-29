vim.pack.add({
    'https://github.com/nvim-mini/mini.nvim',
})

require('mini.ai').setup({
    mappings = {
        around_next = 'aa',
        inside_next = 'ii',
    },
    n_lines = 500,
})

require('mini.surround').setup({})

require('mini.statusline').setup({
    use_icons = true,
    section_location = function()
        return '%2l:%-2v'
    end,
})

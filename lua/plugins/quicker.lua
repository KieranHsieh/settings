vim.pack.add({
    'https://github.com/stevearc/quicker.nvim',
})

local quicker = require('quicker')

quicker.setup({
    keys = {
        {
            '>',
            function()
                require('quicker').expand({ before = 2, after = 2, add_to_existing = true })
            end,
            desc = 'Expand quickfix content',
        },
        {
            '<',
            function()
                require('quicker').collapse()
            end,
            desc = 'Collapse quickfix content',
        },
    },
})

vim.keymap.set('n', '<leader>qfo', quicker.toggle, { desc = '[Q]uick[f]ix List [O]pen' })
vim.keymap.set('n', '<leader>qfn', '<cmd>cnext<CR>', { desc = '[Q]uick[f]ix List [N]ext' })
vim.keymap.set('n', '<leader>qfp', '<cmd>cprev<CR>', { desc = '[Q]uick[f]ix List [P]revious' })

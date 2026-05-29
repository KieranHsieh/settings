vim.pack.add({
    'https://github.com/stevearc/overseer.nvim',
})

require('overseer').setup({
    disable_template_modules = {
        'overseer.template.make',
        '^.*cargo'
    }
})

vim.keymap.set('n', '<leader>rt', '<cmd>OverseerRun<CR>', { desc = '[R]un a [T]ask' })

vim.keymap.set('n', '<F7>', function()
    local overseer = require('overseer')
    overseer.run_task({ tags = { 'BUILD' } })
end, { desc = 'Run Default build task' })

vim.keymap.set('n', '<F5>', function()
    local overseer = require('overseer')
    overseer.run_task({ tags = { 'RUN' } })
end, { desc = 'Run Default run task' })

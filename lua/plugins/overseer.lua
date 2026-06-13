vim.pack.add({
    'https://github.com/stevearc/overseer.nvim',
})

require('overseer').setup({
    --- Disable everything but VS Code Tasks and Justfiles
    disable_template_modules = {
        'overseer.template.cargo',
        'overseer.template.composer',
        'overseer.template.deno',
        'overseer.template.devenv',
        'overseer.template.mage',
        'overseer.template.make',
        'overseer.template.mise',
        'overseer.template.mix',
        'overseer.template.npm',
        'overseer.template.rake',
        'overseer.template.task',
        'overseer.template.tox'
    },
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

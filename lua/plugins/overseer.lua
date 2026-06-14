vim.pack.add({
    'https://github.com/stevearc/overseer.nvim',
})

require('overseer').setup({
    --- Disable everything but VS Code Tasks
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
        'overseer.template.tox',
    },
})

vim.keymap.set('n', '<leader>rt', '<cmd>OverseerRun<CR>', { desc = '[R]un a [T]ask' })

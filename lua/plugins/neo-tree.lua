vim.pack.add({
    'https://github.com/nvim-neo-tree/neo-tree.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/MunifTanjim/nui.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
})
-- ================================================================= --
--
-- Setup
--
-- ================================================================= --
require('neo-tree').setup({
    window = {
        mappings = {
            ['o'] = 'open',
        },
    },
})

-- ================================================================= --
--
-- Keymaps
--
-- ================================================================= --
vim.keymap.set('n', '<leader>se', function()
    require('neo-tree.command').execute({
        reveal = true,
        position = 'left',
        toggle = true,
    })
end, { desc = '[S]earch With File [E]xplorer' })

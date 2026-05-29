vim.pack.add({
    'https://github.com/lewis6991/gitsigns.nvim',
})
require('gitsigns').setup({
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        vim.keymap.set('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
            else
                gitsigns.nav_hunk('next')
            end
        end, { desc = 'Go to next git [C]hange', buf = bufnr })

        vim.keymap.set('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gitsigns.nav_hunk('prev')
            end
        end, { desc = 'Go to next git [C]hange', buf = bufnr })

        vim.keymap.set('n', '<leader>hd', gitsigns.preview_hunk_inline, { desc = 'Show [H]unk [D]iff', buf = bufnr })
        vim.keymap.set('n', '<leader>hb', function()
            gitsigns.blame_line({ full = true })
        end, { desc = 'Show [H]unk [B]lame', buf = bufnr })
    end,
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 500,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
    },
})

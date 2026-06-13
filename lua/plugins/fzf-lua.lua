vim.pack.add({
    'https://github.com/ibhagwan/fzf-lua',
    'https://github.com/nvim-tree/nvim-web-devicons',
})

local fzf = require('fzf-lua')

require('fzf-lua').setup({
    keymap = {
        fzf = {
            ['ctrl-q'] = 'select-all+accept',
        },
    },
    git = {
        status = {
            actions = {
                ['right'] = false,
                ['left'] = false,
                ['ctrl-x'] = { fn = require('fzf-lua').actions.git_reset, reload = true },
                ['ctrl-s'] = { fn = require('fzf-lua').actions.git_stage_unstage, reload = true },
            },
        },
    },
})

fzf.register_ui_select()

-- ================================================================= --
--
-- Keymaps
--
-- ================================================================= --
local function search_hidden_files()
    fzf.files({
        hidden = true,
        no_ignore = true
    })
end

local function search_config_files()
    fzf.files({
        cwd = vim.fn.stdpath('config'),
    })
end

vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', search_hidden_files, { desc = '[S]earch [H]idden Files' })
vim.keymap.set('n', '<leader>sn', search_config_files, { desc = '[S]earch [N]eovim Config' })
vim.keymap.set('n', '<leader>sif', fzf.live_grep_native, { desc = '[S]earch [I]n All [F]iles' })
vim.keymap.set('n', '<leader>sgf', fzf.git_files, { desc = '[S]earch [G]it Files' })
vim.keymap.set('n', '<leader>sgl', fzf.git_commits, { desc = '[S]earch Git [L]og' })
vim.keymap.set('n', '<leader>sgs', fzf.git_status, { desc = '[S]earch Git [C]hanges' })
vim.keymap.set('n', '<leader>skm', fzf.keymaps, { desc = '[S]earch [K]ey [M]appings' })
vim.keymap.set('n', '<leader>sb', fzf.buffers, { desc = '[S]earch Open [B]uffers' })

-- ================================================================= --
--
-- Autocommands
--
-- ================================================================= --
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('fzf-lua-lsp-attach', { clear = true }),
    callback = function(event)
        local buf = event.buf

        vim.keymap.set('n', 'grr', fzf.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })
        vim.keymap.set('n', 'gri', fzf.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementations' })
        vim.keymap.set('n', 'grd', fzf.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })
        vim.keymap.set(
            'n',
            '<leader>sds',
            fzf.lsp_document_symbols,
            { buffer = buf, desc = '[S]earch [D]ocument [S]ymbols' }
        )
        vim.keymap.set(
            'n',
            '<leader>sws',
            fzf.lsp_live_workspace_symbols,
            { buffer = buf, desc = '[S]earch [W]orkspace [S]ymbols' }
        )
    end,
})

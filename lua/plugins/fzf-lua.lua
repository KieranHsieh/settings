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
    defaults = {
        preview_pager = false,
    },
    previewers = {
        git_diff = {
            pager = false,
        },
        builtin = {},
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
        no_ignore = true,
    })
end

local function search_config_files()
    fzf.files({
        cwd = vim.fn.stdpath('config'),
    })
end

local function search_document_functions()
    fzf.lsp_document_symbols({
        query = 'function ',
    })
end

vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', search_hidden_files, { desc = '[S]earch [H]idden Files' })
vim.keymap.set('n', '<leader>sn', search_config_files, { desc = '[S]earch [N]eovim Config' })
vim.keymap.set('n', '<leader>sdt', fzf.lgrep_curbuf, { desc = '[S]earch [D]ocument [T]ext' })
vim.keymap.set('n', '<leader>/', fzf.lgrep_curbuf, { desc = '[S]earch [D]ocument [T]ext' })
vim.keymap.set('n', '<leader>sif', fzf.live_grep_native, { desc = '[S]earch [I]n All [F]iles' })
vim.keymap.set('n', '<leader>sgf', fzf.git_files, { desc = '[S]earch [G]it Files' })
vim.keymap.set('n', '<leader>sgl', fzf.git_commits, { desc = '[S]earch [G]it [L]og' })
vim.keymap.set('n', '<leader>sgs', fzf.git_status, { desc = '[S]earch [G]it [C]hanges' })
vim.keymap.set('n', '<leader>sgt', fzf.git_tags, { desc = '[S]earch [G]it [T]ags' })
vim.keymap.set('n', '<leader>skm', fzf.keymaps, { desc = '[S]earch [K]ey [M]appings' })
vim.keymap.set('n', '<leader>sb', fzf.buffers, { desc = '[S]earch Open [B]uffers' })
vim.keymap.set('v', '<leader>sw', fzf.grep_visual, { desc = '[S]earch Current [W]ord' })
vim.keymap.set('n', '<leader>scs', fzf.colorschemes, { desc = '[S]earch [C]olor [S]chemes' })

-- ================================================================= --
--
-- Autocommands
--
-- ================================================================= --
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('fzf-lua-lsp-attach', { clear = true }),
    callback = function(event)
        local buf = event.buf

        local function add_keymap(mode, map, func, desc)
            vim.keymap.set(mode, map, func, { buffer = buf, desc = desc })
        end

        add_keymap('n', 'grr', fzf.lsp_references, '[G]oto [R]eferences')
        add_keymap('n', 'gri', fzf.lsp_implementations, '[G]oto [I]mplementations')
        add_keymap('n', 'grd', fzf.lsp_definitions, '[G]oto [D]efinition')
        add_keymap('n', '<leader>sds', fzf.lsp_document_symbols, '[S]earch [D]ocumnet [S]ymbols')
        add_keymap('n', '<leader>sdf', search_document_functions, '[S]earch [D]ocumnet [F]unctions')
        add_keymap('n', '<leader>sws', fzf.lsp_live_workspace_symbols, '[S]earch [W]orkspace [S]ymbols')
    end,
})

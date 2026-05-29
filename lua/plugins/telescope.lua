vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name = ev.data.spec.name
        local kind = ev.data.kind

        if kind ~= 'install' and kind ~= 'update' then
            return
        end

        print('Here')

        if name == 'telescope-fzf-native.nvim' and vim.fn.executable('make') == 1 then
            require('kth.util').run_plugin_build_command(name, { 'make' }, ev.data.path)
        end
    end,
})

vim.pack.add({
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-telescope/telescope-ui-select.nvim',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
})

-- ================================================================= --
--
-- Setup
--
-- ================================================================= --
require('telescope').setup({
    extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown({}) },
    },
    defaults = {
        mappings = {
            i = {
                ['<C-j>'] = require('telescope.actions').move_selection_next,
                ['<C-k>'] = require('telescope.actions').move_selection_previous,
                ['<C-o>'] = require('telescope.actions').select_default,
            },
            n = {
                ['o'] = require('telescope.actions').select_default,
            },
        },
    },
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('ui-select')

-- ================================================================= --
--
-- Keymaps
--
-- ================================================================= --
local builtin = require('telescope.builtin')

local function find_config_files()
    builtin.find_files({ cwd = vim.fn.stdpath('config') })
end

local function find_hidden_files()
    builtin.find_files({
        no_ignore = true,
        hidden = true,
    })
end

local function find_plugin_files()
    builtin.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'site', 'pack', 'core', 'opt') })
end

vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sif', builtin.live_grep, { desc = '[S]earch [I]n All [F]iles' })
vim.keymap.set('n', '<leader>sg', builtin.git_files, { desc = '[S]earch [G]it Files' })
vim.keymap.set('n', '<leader>sn', find_config_files, { desc = '[S]earch [N]eovim Config' })
vim.keymap.set('n', '<leader>sp', find_plugin_files, { desc = '[S]earch [P]lugin Source' })
vim.keymap.set('n', '<leader>sh', find_hidden_files, { desc = '[S]earch [H]idden Files' })
vim.keymap.set('n', '<leader>sl', builtin.git_commits, { desc = '[S]earch Git [L]og' })
vim.keymap.set('n', '<leader>sc', builtin.git_status, { desc = '[S]earch Git [C]hanges' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })

-- ================================================================= --
--
-- Autocommands
--
-- ================================================================= --
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
    callback = function(event)
        local buf = event.buf

        vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })
        vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })
        vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })
        vim.keymap.set(
            'n',
            '<leader>sds',
            builtin.lsp_document_symbols,
            { buffer = buf, desc = '[S]earch [D]ocument [S]ymbol' }
        )
        vim.keymap.set(
            'n',
            '<leader>sws',
            builtin.lsp_dynamic_workspace_symbols,
            { buffer = buf, desc = '[S]earch [W]orkspace [S]ymbol' }
        )
        vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
    end,
})

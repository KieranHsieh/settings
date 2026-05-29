-- ================================================================= --
--
-- General/Core Settings
--
-- ================================================================= --
do
    -- Cache compiled Lua modules
    vim.loader.enable()

    -- Leader Key Mappings
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '

    -- Line Numbers
    vim.o.number = true
    vim.o.relativenumber = true

    -- Enable Mouse Support
    vim.o.mouse = 'a'

    -- Save undo history when writing the file
    vim.o.undofile = true

    -- Search Settings
    vim.o.ignorecase = true
    vim.o.smartcase = true

    -- Visual
    vim.o.showmode = false
    vim.o.breakindent = true
    vim.o.signcolumn = 'yes'
    vim.o.cursorline = true
    vim.o.scrolloff = 10
    vim.o.wrap = false

    -- Update Timings
    vim.o.updatetime = 250
    vim.o.timeoutlen = 300

    -- Splits
    vim.o.splitright = true
    vim.o.splitbelow = true

    -- Tabs
    vim.o.expandtab = true
    vim.o.shiftwidth = 4
    vim.o.tabstop = 4

    -- Misc
    vim.o.list = true
    vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
    vim.o.inccommand = 'split'
    vim.o.confirm = true

    vim.schedule(function()
        vim.o.clipboard = 'unnamedplus'
    end)
end

-- ================================================================= --
--
-- Keymap Settings
--
-- ================================================================= --
do
    vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Remove search highlights' })
    vim.keymap.set('n', '<leader>qf', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
    vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left' })
    vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right' })
    vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the down' })
    vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the up' })
    vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = '[S]ave the current buffer' })
    vim.keymap.set('n', '<leader>to', '<cmd>botright 15split | terminal<CR>', { desc = '[T]erminal [O]pen' })

    vim.keymap.set('i', '<C-s>', '<cmd>w<CR>', { desc = '[S]ave the current buffer' })

    vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
end

-- ================================================================= --
--
-- Diagnostic Settings
--
-- ================================================================= --
do
    vim.diagnostic.config({
        update_in_insert = false,
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = { min = vim.diagnostic.severity.WARN } },

        virtual_text = true,
        virtual_lines = false,

        jump = {
            on_jump = function(_, buffer)
                vim.diagnostic.open_float({
                    bufnr = buffer,
                    scope = 'cursor',
                    focus = false,
                })
            end,
        },
    })
end

-- ================================================================= --
--
-- Autocommands
--
-- ================================================================= --
do
    vim.api.nvim_create_autocmd('TextYankPost', {
        desc = 'Highlight when yanking (copying) text',
        group = vim.api.nvim_create_augroup('kth-highlight-yank', { clear = true }),
        callback = function()
            vim.hl.on_yank()
        end,
    })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter', 'TermOpen' }, {
        group = vim.api.nvim_create_augroup('kth-terminal-autoinsert', { clear = true }),
        pattern = 'term://*',
        callback = function()
            vim.cmd('startinsert')
        end
    })
end

-- ================================================================= --
--
-- User Commands
--
-- ================================================================= --
do
    local function pack_clean()
        local active_plugins = {}
        local unused_plugins = {}

        for _, plugin in ipairs(vim.pack.get()) do
            active_plugins[plugin.spec.name] = plugin.active
        end

        for _, plugin in ipairs(vim.pack.get()) do
            if not active_plugins[plugin.spec.name] then
                table.insert(unused_plugins, plugin.spec.name)
            end
        end

        if #unused_plugins == 0 then
            print('No unused plugins')
            return
        end

        local choice = vim.fn.confirm('Remove unused plugins?', '&Yes\n&No', 2)

        if choice == 1 then
            vim.pack.del(unused_plugins)
        end
    end

    local function pack_update()
        vim.pack.update()
    end

    vim.api.nvim_create_user_command('PackClean', pack_clean, {})
    vim.api.nvim_create_user_command('PackUpdate', pack_update, {})
end

-- ================================================================= --
--
-- Plugins
--
-- ================================================================= --
do
    require('plugins.telescope')
    require('plugins.onedarkpro')
    require('plugins.neo-tree')
    require('plugins.neoscroll')
    require('plugins.mason')
    require('plugins.fidget')
    require('plugins.conform')
    require('plugins.nvim-autopairs')
    require('plugins.luasnip')
    require('plugins.blink')
    require('plugins.gitsigns')
    require('plugins.which-key')
    require('plugins.nvim-notify')
    require('plugins.mini')
    require('plugins.overseer')
end

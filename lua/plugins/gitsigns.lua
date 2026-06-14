vim.pack.add({
    'https://github.com/lewis6991/gitsigns.nvim',
})

local gitsigns = require('gitsigns')

local function next_change()
    if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
    else
        gitsigns.nav_hunk('next')
    end
end

local function prev_change()
    if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
    else
        gitsigns.nav_hunk('prev')
    end
end

local function full_blame_line()
    gitsigns.blame_line({ full = true })
end

local function reset_selection()
    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
end

local function setup_gitsigns_keymaps(bufnr)
    local gitsigns = require('gitsigns')

    local function add_keymap(mode, map, func, desc)
        vim.keymap.set(mode, map, func, { buf = bufnr, desc = desc })
    end

    add_keymap('n', ']c', next_change, 'Go to next git [C]hange')
    add_keymap('n', '[c', prev_change, 'Go to previous git [C]hange')
    add_keymap('n', '<leader>gd', gitsigns.preview_hunk, '[G]it [D]iff')
    add_keymap('n', '<leader>gb', full_blame_line, '[G]it [B]lame Current Line')
    add_keymap('v', '<leader>gr', reset_selection, '[G]it [R]eset Selection')
end

require('gitsigns').setup({
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        setup_gitsigns_keymaps(bufnr)
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
    preview_config = {
        border = 'rounded',
    },
})

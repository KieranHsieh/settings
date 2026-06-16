vim.pack.add({
    'https://github.com/mfussenegger/nvim-dap',
    'https://github.com/rcarriga/nvim-dap-ui',
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/jay-babu/mason-nvim-dap.nvim',
    'https://github.com/mason-org/mason.nvim',

    --- Adapters
    'https://github.com/julianolf/nvim-dap-lldb',
})

require('mason-nvim-dap').setup({
    automatic_installation = true,
    ensure_installed = {
        'codelldb',
    },
})

---@diagnostic disable-next-line: missing-fields
require('dapui').setup({
    -- Set icons to characters that are more likely to work in every terminal.
    --    Feel free to remove or use ones that you like more! :)
    --    Don't feel like these are good choices.
    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    ---@diagnostic disable-next-line: missing-fields
    controls = {
        icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
        },
    },
})

require('dap').listeners.after.event_initialized['dapui_config'] = require('dapui').open
require('dap').listeners.before.event_terminated['dapui_config'] = require('dapui').close
require('dap').listeners.before.event_exited['dapui_config'] = require('dapui').close

require('dap-lldb').setup()

vim.keymap.set('n', '<leader>bp', require('dap').toggle_breakpoint, { desc = 'Toggle [B]reak [P]oint' })

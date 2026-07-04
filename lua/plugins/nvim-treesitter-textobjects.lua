vim.pack.add({
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
})

require('nvim-treesitter-textobjects').setup({})

local ts_move = require('nvim-treesitter-textobjects.move')
local ts_repeat_move = require('nvim-treesitter-textobjects.repeatable_move')
local ts_select = require('nvim-treesitter-textobjects.select')

local function select_around_function()
    ts_select.select_textobject('@function.outer', 'textobjects')
end

local function select_inside_function()
    ts_select.select_textobject('@function.inner', 'textobjects')
end

local function select_around_class()
    ts_select.select_textobject('@class.outer', 'textobjects')
end

local function select_inside_class()
    ts_select.select_textobject('@class.inner', 'textobjects')
end

local function next_function()
    ts_move.goto_next_start('@function.outer', 'textobjects')
end

local function previous_function()
    ts_move.goto_previous_start('@function.outer', 'textobjects')
end

vim.keymap.set({ 'n', 'x', 'o' }, ']f', next_function, { desc = 'Goto next function' })
vim.keymap.set({ 'n', 'x', 'o' }, '[f', previous_function, { desc = 'Goto previous next function' })

vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

-- Restore builtin keymappings for repeats
vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })

vim.keymap.set({ 'x', 'o' }, 'af', select_around_function)
vim.keymap.set({ 'x', 'o' }, 'if', select_inside_function)
vim.keymap.set({ 'x', 'o' }, 'ac', select_around_class)
vim.keymap.set({ 'x', 'o' }, 'ac', select_inside_class)

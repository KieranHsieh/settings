vim.pack.add({
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/mason-org/mason-lspconfig.nvim',
    'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
})

-- ================================================================= --
--
-- Setup
--
-- ================================================================= --
local language_servers = {
    stylua = {},
    ['rust_analyzer'] = {},
    neocmake = {},
    ['jsonls'] = {},
    lua_ls = {
        on_init = function(client)
            client.server_capabilities.documentFormattingProvider = false

            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                local path_has_luarc = vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')

                if path ~= vim.fn.stdpath('config') and path_has_luarc then
                    return
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        version = 'LuaJIT',
                        path = { 'lua/?.lua', 'lua/?/init.lua' },
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = vim.api.nvim_get_runtime_file('', true),
                    },
                })
            end
        end,
        settings = {
            Lua = {
                format = { enable = false },
            },
        },
    },
    clangd = {},
}

for name, server in pairs(language_servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
end

require('mason').setup({})

require('mason-tool-installer').setup({
    ensure_installed = vim.tbl_keys(language_servers or {}),
})

-- ================================================================= --
--
-- Autocommands
--
-- ================================================================= --
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kth-lsp-attach', { clear = true }),
    callback = function(event)
        local function add_keymap(mode, map, func, desc)
            vim.keymap.set(mode, map, func, { buffer = event.buf, desc = desc })
        end

        add_keymap('n', 'grn', vim.lsp.buf.rename, '[R]e[n]ame Symbol')
        add_keymap({ 'n', 'x' }, 'gra', '[G]oto Code [A]ction')
        add_keymap('n', 'grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        add_keymap('n', 'grh', vim.lsp.buf.hover, 'Show Symbol [H]over Information')

        -- Highlight references of the word under your cursor after it rests there for a bit
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kth-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('kth-lsp-detach', { clear = true }),
                callback = function(detach_event)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = 'kth-lsp-highlight', buffer = detach_event.buf })
                end,
            })
        end
    end,
})

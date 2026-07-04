vim.pack.add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
})

local treesitter = require('nvim-treesitter')

treesitter.setup({})

local function treesitter_try_attach(buf, language)
    if not vim.treesitter.language.add(language) then
        return
    end

    vim.treesitter.start(buf, language)
end

local available_parsers = require('nvim-treesitter').get_available()
vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        local buf, filetype = args.buf, args.match

        local language = vim.treesitter.language.get_lang(filetype)
        if not language then
            return
        end

        local installed_parsers = treesitter.get_installed('parsers')

        if vim.tbl_contains(installed_parsers, language) then
            treesitter_try_attach(buf, language)
        elseif vim.tbl_contains(available_parsers, language) then
            treesitter.install(language):await(function()
                treesitter_try_attach(buf, language)
            end)
        else
            treesitter_try_attach(buf, language)
        end
    end,
})

vim.pack.add({ 'https://github.com/rcarriga/nvim-notify' })

require('notify').setup({
    render = 'compact',
    stages = 'fade',
    timeout = 3,
    merge_duplicates = false,
})

vim.notify = require('notify')

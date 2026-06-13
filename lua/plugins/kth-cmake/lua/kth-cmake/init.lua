---@class kth-cmake.CodemodelTarget
---@field name string
---@field id string
---@field jsonFile string

---@class kth-cmake.CodemodelConfiguration
---@field targets kth-cmake.CodemodelTarget[]

---@class kth-cmake.Codemodel
---@field configurations kth-cmake.CodemodelConfiguration[]

local M = {}

function M.write_query_file(build_directory)
    local query_file =
        vim.fs.joinpath(build_directory, '.cmake', 'api', 'v1', 'query', 'client-nvim-cmake-file-api', 'query.json')

    local query_data = {
        ['requests'] = {
            { kind = 'codemodel', version = '2' },
            { kind = 'cache', version = '2' },
            { kind = 'cmakeFiles', version = '1' },
        },
    }

    local encoded_query_data = vim.json.encode(query_data)

    vim.fn.writefile(encoded_query_data, query_file)
end

function M.setup()
    vim.api.nvim_create_user_command('CMake', function(args)
        local command = args.fargs[1]

        print(command or 'No command provided')
    end, { nargs = '+' })
end

return M

-- This assumes you are using the nvim-dap-python plugin or have configured
-- the Python debug adapter (`debugpy`) directly with nvim-dap.

-- local dap = require('dap')

-- Define or extend the Python debug configuration
-- if not dap.adapters.python then
--     dap.adapters.python = {
--         type = 'executable',
--         command = 'python',
--         -- Adjust the path to your debugpy installation if necessary
--         args = { '-m', 'debugpy.adapter' },
--     }
-- end

-- Function to generate the configuration dynamically
local function get_pytest_config(test_path, env_vars)
    -- The core logic for running a test function in debug mode.
    -- 1. Sets the program to 'pytest'
    -- 2. Passes the specific test function path as an argument.
    -- 3. Injects custom environment variables.

    -- The 'args' format:
    -- [file::test_name, --no-header, --no-summary, --fail-on-template-vars, ...]

    local program_path = vim.fn.expand(test_path)

    local result = {
        type = 'python',
        request = 'launch',
        name = 'DAP Run Pytest Function (Custom Config)',

        -- Specify the executable (your virtual environment python or just 'python')
        python = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python',

        -- Tell the adapter to run the 'pytest' module
        module = 'pytest',

        -- Arguments passed to pytest
        args = {
            program_path,
            '--reuse-db',
            '--no-migrations',
            -- Add any other necessary pytest flags here,
            -- e.g., --cov-report= to disable coverage if it conflicts
        },

        -- IMPORTANT: Injecting Project-Specific Configuration / Environment Variables
        env = env_vars,

        -- Optional: Working directory
        cwd = vim.fn.getcwd(),

        -- Debugging options
        console = 'integratedTerminal',
        stopOnEntry = false,
    }
    print(result)
    return result
end


-- =========================================================================
--  3. Final Configuration Setup (Used by the user)
-- =========================================================================

-- Example of the project-specific environment variables you need
local project_env_vars = {
    -- Replace these with your actual keys and values
    -- Note: DAP often prefers environment variables in a dictionary format:
    -- { DJANGO_SETTINGS_MODULE = 'api.settings.testing', ... }
    -- But some adapters handle array format. We'll use the dictionary format below for reliability.

    DJANGO_SETTINGS_MODULE = 'api.settings.testing',
    DJANGO_CONFIGURATION = 'Test',
}

-- Register the configuration with the Test Runner function path
-- dap.configurations.python = {
--     get_pytest_config(
--         '${file}::${name}', -- Standard DAP placeholders for file/function name
--         project_env_vars    -- The project-specific environment variables
--     ),
-- }
local env_vars = {
    DJANGO_SETTINGS_MODULE = 'api.settings.testing',
    DJANGO_CONFIGURATION = 'Test',
}

-- Define a custom command to make running the test function easier
table.insert(require('dap').configurations.python,
    {
        type = 'python',
        request = 'launch',
        name = 'static',

        -- Specify the executable (your virtual environment python or just 'python')
        python = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python',

        -- Tell the adapter to run the 'pytest' module
        module = 'pytest',

        -- Arguments passed to pytest
        args = {
            '${file}',
            '--reuse-db',
            '--no-migrations',
            -- Add any other necessary pytest flags here,
            -- e.g., --cov-report= to disable coverage if it conflicts
        },

        -- IMPORTANT: Injecting Project-Specific Configuration / Environment Variables
        env = env_vars,

        -- Optional: Working directory
        cwd = vim.fn.getcwd(),

        -- Debugging options
        console = 'integratedTerminal',
        stopOnEntry = false,
    }
)

-- require('dap-python').setup('debugpy-adapter') -- or uv, or path to python, see #usage
-- table.insert(require('dap').configurations.python, {
--     type = 'python',
--     request = 'launch',
--     name = 'My custom launch configuration',

--     -- `program` is what you'd use in `python <program>` in a shell
--     -- If you need to run the equivalent of `python -m <module>`, replace
--     -- `program = '${file}` entry with `module = "modulename"
--     program = '${file}',

--     console = "integratedTerminal",

--     -- Other options:
--     -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
-- })

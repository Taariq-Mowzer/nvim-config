local dap = require("dap")

vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

vim.api.nvim_create_user_command("DBG", function() dap.continue(); dap.repl.open() end, {})
vim.keymap.set('n', '<leader>bp', dap.toggle_breakpoint, {})
vim.keymap.set('n', '<leader>repl', dap.repl.open, {})
vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F6>', dap.step_over)
vim.keymap.set('n', '<F7>', dap.step_into)
vim.keymap.set('n', '<F8>', dap.step_out)

local function getPython()
	-- Use the current virtual environment's python if available
    local venv_path = os.getenv("VIRTUAL_ENV")
    if venv_path then
    	return venv_path .. "/bin/python"
	end
    return '/usr/bin/python'
end


dap.adapters.python = {
    type = 'executable';
    command = getPython();
    args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}",
        pythonPath = getPython,
	},
}


vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("n", "<leader>vs", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>hs", vim.cmd.split)

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.ts=4
vim.opt.sw=4
vim.opt.smartindent = true

vim.api.nvim_create_user_command('RP', function()
	local file_ext = vim.fn.expand('%:e')

	local run_cmds = {
		py = "term python %",
	}

  	run_cmd = run_cmds[file_ext]
	
  	if run_cmd then
		vim.cmd("vs")
		vim.cmd(run_cmd)
	else
		print("Unsure how to run ." .. file_ext .. " file.")
  	end
end, {})

vim.api.nvim_create_user_command("Spellcheck", function()
  vim.opt_local.spell = true
  vim.opt_local.spelllang = "en_gb"
end, {})


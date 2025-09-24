vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("n", "<leader>=", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>-", vim.cmd.split)

-- Move between splits with <leader> + h/j/k/l
vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>l", "<C-w>l")
-- Move to next split with <leader> + o
vim.keymap.set("n", "<leader>o", "<C-w>w")

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

-- From insert mode jk goes into normal mode
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })
-- From insert mode kj moves one to the right
vim.api.nvim_set_keymap('i', 'kj', '<Right>', { noremap = true, silent = true })

-- Timoutlen for key combos is 200 ms in insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    callback = function()
        vim.opt.timeoutlen = 200
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
        vim.opt.timeoutlen = 1000
    end,
})


vim.api.nvim_create_user_command("Spellcheck", function()
  vim.opt_local.spell = true
  vim.opt_local.spelllang = "en_gb"
end, {})

vim.api.nvim_create_augroup("PersistentViews", { clear = true })

vim.api.nvim_create_autocmd({"BufWinLeave", "BufWinEnter"}, {
    group = "PersistentViews",
    pattern = "*.*",
    callback = function(args)
        if args.event == "BufWinLeave" then
            vim.cmd("mkview")
        elseif args.event == "BufWinEnter" then
            vim.cmd("silent! loadview")
        end
    end,
})


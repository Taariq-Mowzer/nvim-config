local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

vim.api.nvim_create_user_command("LS", function()
  vim.cmd("Telescope buffers")
end, {})

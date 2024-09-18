local autopairs = require("nvim-autopairs")

autopairs.setup({})

local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')

autopairs.add_rules({
    Rule("$", "$", "tex")
        :with_move(cond.after_text("$") and cond.not_before_char("$")),
})

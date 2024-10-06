local ls = require("luasnip")
local snippet = ls.snippet
local sn = ls.snippet_node
local text = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local function auto_pair(open, close)
	auto_complete_snippet = snippet(
		{trig=open, snippetType="autosnippet", wordTrig=false},
		fmta(
			open .. "<>" .. close .. "<>",
			{i(1), i(0)}
		)
	)

	return auto_complete_snippet
end

return {
	auto_pair("(", ")"),
	auto_pair("[", "]"),
	auto_pair("{", "}"),
	auto_pair('"', '"'),
}

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

local tex_utils = {}
tex_utils.in_mathzone = function()  -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex_utils.in_text = function()
  return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function()  -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() == 1
end
tex_utils.in_env = function(name)  -- generic environment detection
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex_utils.in_equation = function()  -- equation environment detection
    return tex_utils.in_env('equation')
end
tex_utils.in_itemize = function()  -- itemize environment detection
    return tex_utils.in_env('itemize')
end
tex_utils.in_tikz = function()  -- TikZ picture environment detection
    return tex_utils.in_env('tikzpicture')
end


return {
-- Examples of Greek letter snippets, autotriggered for efficiency
	snippet({trig=";a", snippetType="autosnippet"},
  {
    text("\\alpha"),
  }
),
	snippet({trig=";b", snippetType="autosnippet"},
  {
    text("\\beta"),
  }
),
	snippet({trig=";g", snippetType="autosnippet"},
  {
    text("\\gamma"),
  }
),

	snippet({trig="\\beg", snippetType="autosnippet"},
  		fmta("\\begin{<>}\n    <>\n\\end{<>}",
    		{
				i(1),
      			i(2),
      			rep(1),  -- this node repeats insert node i(1)
    		}
  		)
	),
	snippet({trig="eq"},
  		fmta("\\[\n    <>\n\\]",
    		{
				i(1),
    		}
  		),
		{
			condition = tex_utils.in_text,
		}
	),
	snippet({trig="im"},
  		fmta("\\(<>\\)<>",
    		{
				i(1),
				i(2),
    		}
  		),
		{
			condition = tex_utils.in_text,
		}
	),
	snippet({trig="::"},
  		fmta("{{c<>:: <> }}<>",
    		{
				i(1),
				i(2),
				i(3),
    		}
  		),
		{
			condition = tex_utils.in_text,
		}
	),

	snippet({trig="\\i"},
  {
    text("\\item "),
  },
  {
	  condition = tex_utils.in_itemize,
  }
),
}


local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

return {
  s({
    trig = "hd",
    name = "Add header line",
  }, {
    t(
      "-- ==================================================================== "
    ),
    i(1, "title"),
    t(""),
    i(0),
  }),
}

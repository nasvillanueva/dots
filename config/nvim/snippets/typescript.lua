local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

local is_test_file = function()
  local fname = vim.api.nvim_buf_get_name(0)
  return fname:match("%.spec%.ts$") or fname:match("%.test%.ts$")
end

return {
  s({
    trig = "descr",
    name = "Test `describe` block",
    condition = is_test_file,
  }, {
    t('describe("'),
    i(1, "title"),
    t({ '", () => {', "  " }),
    i(0),
    t({ "", "});" }),
  }),
  s({
    trig = "bfe",
    name = "Test `beforeEach` block",
    condition = is_test_file,
  }, {
    t("beforeEach(() => {", "  "),
    i(0),
    t({ "", "});" }),
  }),
  s({
    trig = "bfea",
    name = "Test async `beforeEach` block",
    condition = is_test_file,
  }, {
    t("beforeEach(async () => {", "  "),
    i(0),
    t({ "", "});" }),
  }),
  s({
    trig = "afe",
    name = "Test `afterEach` block",
    condition = is_test_file,
  }, {
    t("afterEach(() => {", "  "),
    i(0),
    t({ "", "});" }),
  }),
  s({
    trig = "afea",
    name = "Test async `afterEach` block",
    condition = is_test_file,
  }, {
    t("afterEach(async () => {", "  "),
    i(0),
    t({ "", "});" }),
  }),
  s({
    trig = "it",
    name = "Test `it` block",
    condition = is_test_file,
  }, {
    t('it("should '),
    i(1, "title"),
    t({ '", () => {', "  " }),
    i(0),
    t({ "", "});" }),
  }),
  s({
    trig = "ita",
    name = "Test async `it` block",
    condition = is_test_file,
  }, {
    t('it("should '),
    i(1, "title"),
    t({ '", async () => {', "  " }),
    i(0),
    t({ "", "});" }),
  }),
}

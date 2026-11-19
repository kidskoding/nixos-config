local neotest = require("neotest")

neotest.setup({
  adapters = {
    require("neotest-python"),
    require("rustaceanvim.neotest"),
    require("neotest-golang"),
  },
})

local function map(key, action, desc) vim.keymap.set("n", key, action, { desc = desc }) end

map("<leader>tt", function() neotest.run.run() end, "run nearest test")
map("<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, "run file tests")
map("<leader>ta", function() neotest.run.run(vim.fn.getcwd()) end, "run all tests")
map("<leader>ts", function() neotest.summary.toggle() end, "test summary")
map("<leader>to", function() neotest.output.open({ enter = true }) end, "test output")

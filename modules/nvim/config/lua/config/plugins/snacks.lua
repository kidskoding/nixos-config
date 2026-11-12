local snacks = require("snacks")
local persistence = require("persistence")

persistence.setup()
vim.opt.sessionoptions:remove("blank")

local function open_project(dir)
  vim.fn.chdir(dir)
  vim.cmd.Oil(dir)
end

-- {} marks the eyes: odd parts render orange, even parts in fg
local ferris_art = {
  "                  .   ,.                      ",
  "              ;. .xo.:xd',do  '.              ",
  "          ..  ddodddddddddddoodo  .           ",
  "          :dooddddddddddddddddddldd           ",
  "       c:,odddddllllllllllllllllllo:,:.       ",
  "       ,oooooolllllllllllllllllllllllo        ",
  "    .ccoooolllllllllllllllllllllllllllccc     ",
  "     loollllllllllllllllllllllllllllllll.     ",
  "  .;:lllllllllllllllllllllllclllllllllllc;,   ",
  "   .lllllllllllll{WWl} .lllc{WW.} clllllllllll    ",
  "  .:llllllllllll  {x},  :ll, {x}  'llllllccccc'   ",
  " ,lllllllllllllll    .ccc:    ;ccccccccccccc;.",
  "ccc. l.:cccccccc:;;;:cccccc,,:ccccccccc y' cc,",
  " .ll  l  ;c:;:dddd;,':cc:,;dddd;:;.:c. y  .c. ",
  "   ll      c,ddcc dd'        ccdd,c.      yy  ",
  "    ll       .cc:.          .;::'        yy   ",
  "               '::;'.    ..,;;.         yy    ",
}

local ferris = {}
for i, part in ipairs(vim.split(table.concat(ferris_art, "\n"), "[{}]")) do
  ferris[i] = { part, hl = i % 2 == 0 and "GruvboxFg0" or "GruvboxOrange" }
end

local v = vim.version()
local version = ("NVIM v%d.%d.%d"):format(v.major, v.minor, v.patch)

local dashboard = {
  enabled = false,
  formats = {
    icon = function(item)
      if item.icon == "directory" then
        local icon = snacks.dashboard.icon(item.file, item.icon)
        icon.hl = "icon"
        return icon
      end
      return { item.icon, width = 2, hl = "icon" }
    end,
  },
  preset = {
    keys = {
      { icon = " ", key = "p", desc = "Open Project", action = function() snacks.picker.projects() end },
      { icon = "󰈞 ", key = "f", desc = "File Browser", action = ":Oil ." },
      { icon = " ", key = "r", desc = "Recent Files", action = function() snacks.picker.recent() end },
      { icon = " ", key = "g", desc = "Find Text", action = function() snacks.picker.grep() end },
      {
        icon = " ",
        key = "c",
        desc = "Config",
        action = function() open_project(vim.fn.stdpath("config")) end,
      },
      {
        icon = "󰦛 ",
        key = "s",
        desc = "Restore Session",
        action = function() persistence.load({ last = true }) end,
      },
      { icon = " ", key = "q", desc = "Quit", action = ":qa" },
    },
  },
  sections = {
    { text = ferris, align = "center", padding = 2 },
    { title = "Recent Projects", section = "projects", action = open_project, padding = 1 },
    { section = "keys", padding = 1 },
    { text = { { version, hl = "GruvboxBg4" } }, align = "center" },
  },
}

snacks.setup({
  bigfile = { enabled = true },
  dashboard = dashboard,
  indent = { enabled = true },
  lazygit = { configure = false },
  styles = { lazygit = { wo = { winhighlight = "NormalFloat:Normal" } } },
  picker = {
    enabled = true,
    sources = {
      explorer = { hidden = true, ignored = true },
      projects = {
        confirm = function(picker, item)
          picker:close()
          if item then open_project(item.file) end
        end,
        dev = {
          "~/uiuc/go-mama-27/personal-projects",
          "~/uiuc",
          "~/contributing",
          "~/playground",
        },
      },
    },
  },
})

-- file icons by basename, so full paths still match filename rules
local icon = snacks.util.icon
snacks.util.icon = function(name, cat, opts) return icon(cat == "file" and vim.fs.basename(name) or name, cat, opts) end

-- after snacks.setup so todo-comments registers its picker source
require("todo-comments").setup({})

local function map(key, action, desc) vim.keymap.set("n", key, action, { desc = desc }) end

map("<leader>ff", function() snacks.picker.files() end, "Find files")
map("<leader>/", function() snacks.picker.grep() end, "Search project")
map("<leader>e", function() snacks.picker.explorer() end, "File explorer")
map("<leader>p", function() snacks.picker.projects() end, "Switch project")
map("<leader>h", function() snacks.picker.help() end, "Search help pages")
map("<leader>bb", function() snacks.picker.buffers() end, "Switch buffer")
map("<leader>bd", function() snacks.bufdelete() end, "Close buffer")
map("<leader>gz", function() snacks.lazygit() end, "Lazygit")
map("<leader>rb", function() snacks.terminal("bacon", { win = { position = "float" } }) end, "Bacon")
map("<leader>gB", function() snacks.gitbrowse() end, "Open file on GitHub")
map("<leader>gl", function() snacks.picker.git_log_file() end, "File git history")
map("<leader>gb", function() snacks.git.blame_line() end, "Blame line")
map("<leader>gL", function() snacks.picker.git_log_line() end, "Line git history")
map("<leader>gs", function() snacks.picker.git_status() end, "Git status")
map("<leader>gd", function() snacks.picker.git_diff() end, "Git diff hunks")
map("<leader>gi", function() snacks.picker.gh_issue() end, "GitHub issues (open)")
map("<leader>gI", function() snacks.picker.gh_issue({ state = "all" }) end, "GitHub issues (all)")
map("<leader>gp", function() snacks.picker.gh_pr() end, "GitHub pull requests (open)")
map("<leader>gP", function() snacks.picker.gh_pr({ state = "all" }) end, "GitHub pull requests (all)")
map("<leader>xt", function() snacks.picker.todo_comments() end, "Todo list")
map("<leader>.", function() snacks.scratch() end, "Toggle scratch buffer")
map("<leader>S", function() snacks.scratch.select() end, "Select scratch buffer")

-- some terminals send <C-_> for <C-/>
vim.keymap.set({ "n", "t" }, "<C-/>", function() snacks.terminal() end, { desc = "Toggle terminal" })
vim.keymap.set({ "n", "t" }, "<C-_>", function() snacks.terminal() end, { desc = "which_key_ignore" })

-- add jk escape sequence for terminals, EXCEPT for lazygit and bacon (j/k scroll)!
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(ev)
    if ev.match:find("lazygit") or ev.match:find("bacon") then return end
    vim.keymap.set("t", "jk", "<C-\\><C-n>", { buffer = ev.buf, desc = "Exit terminal mode" })
  end,
})

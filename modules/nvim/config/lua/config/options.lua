vim.g.mapleader = " "

vim.o.clipboard = "unnamedplus"
vim.o.number = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.cursorline = true
vim.o.cursorlineopt = "screenline,number"

vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down (screen line)" })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up (screen line)" })

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4

-- show diagnostics as lines under the cursor's line only
vim.diagnostic.config({ virtual_lines = { current_line = true } })

-- current_line diagnostics render on CursorHold, which waits updatetime (default 4000ms)
vim.o.updatetime = 50

vim.filetype.add({ extension = { mdx = "mdx" } })

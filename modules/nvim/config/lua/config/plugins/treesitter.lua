require("treesitter-context").setup({ max_lines = 3, separator = nil })

vim.treesitter.language.register("markdown", "mdx")

-- highlight and indent with treesitter when a parser exists for the filetype
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if pcall(vim.treesitter.start) then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
  end,
})

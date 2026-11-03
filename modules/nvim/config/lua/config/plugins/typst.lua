-- use tinymist and websocat from PATH instead of downloading them
require("typst-preview").setup({
  dependencies_bin = { tinymist = "tinymist", websocat = "websocat" },
})

local function open_zathura(path)
  local job = vim.g.zathura_job
  if job and vim.fn.jobwait({ job }, 0)[1] == -1 then vim.fn.jobstop(job) end
  vim.g.zathura_job = vim.fn.jobstart({ "zathura", path }, { detach = true })
end

local function open_typst_pdf()
  local client = vim.lsp.get_clients({ name = "tinymist", bufnr = 0 })[1]

  if vim.bo.filetype ~= "typst" then
    return vim.notify("Open a Typst file first", vim.log.levels.WARN)
  elseif vim.fn.executable("zathura") == 0 then
    return vim.notify("Zathura is not installed", vim.log.levels.ERROR)
  elseif not client then
    return vim.notify("Tinymist is still starting; try again shortly", vim.log.levels.WARN)
  end

  client:request("workspace/executeCommand", {
    command = "tinymist.exportPdf",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }, function(err, result)
    if err or not result or type(result.path) ~= "string" then
      local msg = err and err.message or "check Typst diagnostics"
      return vim.notify("PDF export failed: " .. msg, vim.log.levels.ERROR)
    end
    open_zathura(result.path)
  end, 0)
end

local function map(key, action, desc) vim.keymap.set("n", key, action, { desc = desc }) end

map("<leader>Tp", open_typst_pdf, "Open Typst PDF in Zathura")
map("<leader>TP", "<cmd>TypstPreviewToggle<CR>", "Toggle Typst browser preview")

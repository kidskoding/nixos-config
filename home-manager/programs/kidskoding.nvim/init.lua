-- nix puts hotpot on the runtimepath! Outside Nix, clone it once.

if #vim.api.nvim_get_runtime_file("lua/hotpot.lua", false) == 0 then
  local path = vim.fn.stdpath("data") .. "/lazy/hotpot.nvim"
  if not vim.uv.fs_stat(path) then
    vim.fn.system({
      "git", "clone", "--filter=blob:none", "--branch=v2.1.3",
      "https://github.com/rktjmp/hotpot.nvim.git", path,
    })
  end
  vim.opt.runtimepath:prepend(path)
end

require("hotpot")
require("config")

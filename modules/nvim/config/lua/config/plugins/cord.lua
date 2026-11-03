-- discord rich presence
require("cord").setup({
  variables = true,
  text = {
    viewing = "eyeing up ${filename}",
    editing = "actively cooking in ${filename}",
    workspace = "locked in: ${workspace}",
  },
  editor = { tooltip = "not vscode lmao" },
  idle = { details = "currently touching grass" },
})

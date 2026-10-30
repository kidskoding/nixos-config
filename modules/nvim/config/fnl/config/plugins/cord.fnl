(vim.pack.add ["https://github.com/vyfor/cord.nvim"])

(local cord (require :cord))

;; discord rich presence
(cord.setup {:variables true
             :text {:viewing "eyeing up ${filename}"
                    :editing "actively cooking in ${filename}"
                    :workspace "locked in: ${workspace}"}
             :editor {:tooltip "not vscode lmao"}
             :idle {:details "currently touching grass"}})

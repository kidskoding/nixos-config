(vim.pack.add ["https://github.com/chomosuke/typst-preview.nvim"])

(local typst-preview (require :typst-preview))

;; use tinymist and websocat from PATH instead of downloading them
(typst-preview.setup {:dependencies_bin {:tinymist :tinymist
                                         :websocat :websocat}})

(fn open-typst-pdf []
  (let [client (. (vim.lsp.get_clients {:name :tinymist :bufnr 0}) 1)]
    (if (not= vim.bo.filetype :typst)
        (vim.notify "Open a Typst file first" vim.log.levels.WARN)
        (= (vim.fn.executable :zathura) 0)
        (vim.notify "Zathura is not installed" vim.log.levels.ERROR)
        (not client)
        (vim.notify "Tinymist is still starting; try again shortly"
                    vim.log.levels.WARN)
        (client:request :workspace/executeCommand
                        {:command :tinymist.exportPdf
                         :arguments [(vim.api.nvim_buf_get_name 0)]}
                        (fn [err result]
                          (if (or err (not result)
                                  (not= (type result.path) :string))
                              (vim.notify (.. "PDF export failed: "
                                              (or (?. err :message)
                                                  "check Typst diagnostics"))
                                          vim.log.levels.ERROR)
                              (do
                                (when (and vim.g.zathura_job
                                           (= (. (vim.fn.jobwait [vim.g.zathura_job]
                                                                 0)
                                                 1)
                                              -1))
                                  (vim.fn.jobstop vim.g.zathura_job))
                                (set vim.g.zathura_job
                                     (vim.fn.jobstart [:zathura result.path]
                                                      {:detach true})))))
                        0))))

(fn map [key action desc]
  (vim.keymap.set :n key action {: desc}))

(map :<leader>Tp open-typst-pdf "Open Typst PDF in Zathura")
(map :<leader>TP :<cmd>TypstPreviewToggle<CR> "Toggle Typst browser preview")

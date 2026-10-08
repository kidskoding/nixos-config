(vim.pack.add ["https://github.com/nvim-neotest/nvim-nio"
               "https://github.com/nvim-neotest/neotest"
               "https://github.com/nvim-neotest/neotest-python"])

(local neotest (require :neotest))

(neotest.setup {:adapters [(require :neotest-python)
                           (require :rustaceanvim.neotest)]})

(fn map [key action desc]
  (vim.keymap.set :n key action {: desc}))

(map :<leader>tt #(neotest.run.run) "Run nearest test")
(map :<leader>tf #(neotest.run.run (vim.fn.expand "%")) "Run file tests")
(map :<leader>ts #(neotest.summary.toggle) "Test summary")
(map :<leader>to #(neotest.output.open {:enter true}) "Test output")

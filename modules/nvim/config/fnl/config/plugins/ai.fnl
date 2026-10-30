(vim.pack.add ["https://github.com/coder/claudecode.nvim"
               "https://github.com/folke/sidekick.nvim"])

(local claudecode (require :claudecode))
(local sidekick (require :sidekick))
(local sidekick-cli (require :sidekick.cli))

(claudecode.setup {:terminal {:split_width_percentage 0.3
                              :snacks_win_opts {:wo {:winbar ""}}}})

(sidekick.setup {:nes {:enabled false}
                 :cli {:win {:split {:width 0.3}}
                       :tools {:agy {:cmd [:agy] :is_proc "\\<agy"}}}})

(fn map [key cmd desc]
  (vim.keymap.set :n key (.. :<cmd> cmd :<CR>) {: desc}))

(map :<leader>aa :ClaudeCode "Toggle Claude Code")
(map :<leader>ar "ClaudeCode --resume" "Resume Claude session")
(map :<leader>aC "ClaudeCode --continue" "Continue last Claude session")
(map :<leader>ay :ClaudeCodeDiffAccept "Accept Claude Code diff")
(map :<leader>an :ClaudeCodeDiffDeny "Deny Claude Code diff")
(vim.keymap.set :v :<leader>as :<cmd>ClaudeCodeSend<CR>
                {:desc "Send selection to Claude Code"})

(vim.keymap.set :n :<leader>at #(sidekick-cli.toggle)
                {:desc "Toggle agent CLI"})

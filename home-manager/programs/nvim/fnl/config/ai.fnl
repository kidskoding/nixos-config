(vim.pack.add ["https://github.com/coder/claudecode.nvim"
               "https://github.com/olimorris/codecompanion.nvim"])

(local claudecode (require :claudecode))
(local codecompanion (require :codecompanion))

(claudecode.setup {})
(codecompanion.setup {:interactions {:chat {:adapter :claude_code}
                                     :inline {:adapter :claude_code}}})

(fn map [key cmd desc]
  (vim.keymap.set :n key (.. :<cmd> cmd :<CR>) {: desc}))

(map :<leader>aa :ClaudeCode "Toggle Claude Code")
(map :<leader>ay :ClaudeCodeDiffAccept "Accept Claude Code diff")
(map :<leader>an :ClaudeCodeDiffDeny "Deny Claude Code diff")
(map :<leader>ac "CodeCompanionChat Toggle" "Toggle ACP chat")
(map :<leader>ap :CodeCompanionActions "ACP action palette")
(vim.keymap.set :v :<leader>as :<cmd>ClaudeCodeSend<CR>
                {:desc "Send selection to Claude Code"})

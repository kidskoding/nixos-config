let
  normal = key: action: desc: {
    mode = "n";
    inherit key action;
    options.desc = desc;
  };

  bufdelete = [
    (normal "<leader>bd" "<cmd>lua Snacks.bufdelete()<CR>" "Close buffer")
  ];

  claudecode = [
    (normal "<leader>aa" "<cmd>ClaudeCode<CR>" "Toggle Claude Code")
    (normal "<leader>ay" "<cmd>ClaudeCodeDiffAccept<CR>" "Accept Claude Code diff")
    (normal "<leader>an" "<cmd>ClaudeCodeDiffDeny<CR>" "Deny Claude Code diff")

    {
      mode = "v";
      key = "<leader>as";
      action = "<cmd>ClaudeCodeSend<CR>";
      options.desc = "Send selection to Claude Code";
    }
  ];

  codecompanion = [
    (normal "<leader>ac" "<cmd>CodeCompanionChat Toggle<CR>" "Toggle ACP chat")
    (normal "<leader>ap" "<cmd>CodeCompanionActions<CR>" "ACP action palette")
  ];

  dadbod = [
    (normal "<leader>Du" "<cmd>DBUIToggle<CR>" "Toggle database UI")
    (normal "<leader>Df" "<cmd>DBUIFindBuffer<CR>" "Find database buffer")
    (normal "<leader>Dr" "<cmd>DBUIRenameBuffer<CR>" "Rename database buffer")
    (normal "<leader>Dq" "<cmd>DBUILastQueryInfo<CR>" "Last query info")
    (normal "<leader>Da" "<cmd>DBUIAddConnection<CR>" "Add database connection")
  ];

  conform = [
    (normal "<leader>cf" "<cmd>lua require('conform').format({ lsp_format = 'fallback' })<CR>"
      "Format buffer"
    )
  ];

  gitbrowse = [
    (normal "<leader>gB" "<cmd>lua Snacks.gitbrowse()<CR>" "Open file on GitHub")
  ];

  neogit = [
    (normal "<leader>gg" "<cmd>Neogit<CR>" "Git status")
  ];

  oil = [
    (normal "-" "<cmd>Oil<CR>" "Browse parent directory")
  ];

  picker = [
    (normal "<leader><space>" "<cmd>lua Snacks.picker.files()<CR>" "Find files")
    (normal "<leader>ff" "<cmd>lua Snacks.picker.files()<CR>" "Find files")
    (normal "<leader>/" "<cmd>lua Snacks.picker.grep()<CR>" "Search project")
    (normal "<leader>bb" "<cmd>lua Snacks.picker.buffers()<CR>" "Switch buffer")
    (normal "<leader>e" "<cmd>lua Snacks.picker.explorer()<CR>" "File explorer")
    (normal "gd" "<cmd>lua Snacks.picker.lsp_definitions()<CR>" "Go to definition")
    (normal "grr" "<cmd>lua Snacks.picker.lsp_references()<CR>" "References")
  ];

  rustaceanvim = [
    (normal "<leader>ra" "<cmd>RustLsp codeAction<CR>" "Rust code action")
    (normal "<leader>rr" "<cmd>RustLsp runnables<CR>" "Rust runnables")
    (normal "<leader>rt" "<cmd>RustLsp testables<CR>" "Rust testables")
    (normal "<leader>re" "<cmd>RustLsp explainError<CR>" "Explain Rust error")
  ];

  scratch = [
    (normal "<leader>S" "<cmd>lua Snacks.scratch()<CR>" "Scratch buffer")
    (normal "<leader>Ss" "<cmd>lua Snacks.scratch.select()<CR>" "Select scratch buffer")
  ];

  terminal = [
    {
      mode = [
        "n"
        "t"
      ];
      key = "<C-/>";
      action = "<cmd>lua Snacks.terminal()<CR>";
      options.desc = "Toggle terminal";
    }
    {
      mode = [
        "n"
        "t"
      ];
      key = "<C-_>";
      action = "<cmd>lua Snacks.terminal()<CR>";
      options.desc = "which_key_ignore";
    }
  ];

  toggle = [
    (normal "<leader>ts" "<cmd>lua Snacks.toggle.option('spell')<CR>" "Toggle spell")
    (normal "<leader>tw" "<cmd>lua Snacks.toggle.option('wrap')<CR>" "Toggle wrap")
    (normal "<leader>ti" "<cmd>lua Snacks.toggle.inlay_hints()<CR>" "Toggle inlay hints")
  ];

  trouble = [
    (normal "<leader>cd" "<cmd>Trouble diagnostics toggle filter.buf=0<CR>" "Buffer diagnostics")
    (normal "<leader>cs" "<cmd>Trouble symbols toggle focus=false<CR>" "Symbols")
    (normal "<leader>cl" "<cmd>Trouble lsp toggle focus=false win.position=right<CR>"
      "LSP definitions / references"
    )
    (normal "<leader>xq" "<cmd>Trouble qflist toggle<CR>" "Quickfix list")
    (normal "<leader>xl" "<cmd>Trouble loclist toggle<CR>" "Location list")
  ];

  typst = [
    (normal "<leader>tp" {
      __raw = ''
        function()
          if vim.bo.filetype ~= "typst" then
            return vim.notify("Open a Typst file first", vim.log.levels.WARN)
          end
          if vim.fn.executable("zathura") == 0 then
            return vim.notify("Zathura is not installed", vim.log.levels.ERROR)
          end
          local client = vim.lsp.get_clients({ name = "tinymist", bufnr = 0 })[1]
          if not client then
            return vim.notify("Tinymist is still starting; try again shortly", vim.log.levels.WARN)
          end
          client:request("workspace/executeCommand", {
            command = "tinymist.exportPdf",
            arguments = { vim.api.nvim_buf_get_name(0) },
          }, function(err, result)
            if err or not result or type(result.path) ~= "string" then
              return vim.notify("PDF export failed: " .. (err and err.message or "check Typst diagnostics"), vim.log.levels.ERROR)
            end
            if vim.g.cs374_zathura_job and vim.fn.jobwait({ vim.g.cs374_zathura_job }, 0)[1] == -1 then
              vim.fn.jobstop(vim.g.cs374_zathura_job)
            end
            vim.g.cs374_zathura_job = vim.fn.jobstart({ "zathura", result.path }, { detach = true })
          end, 0)
        end
      '';
    } "Open Typst PDF in Zathura")
    (normal "<leader>tP" "<cmd>TypstPreviewToggle<CR>" "Toggle Typst browser preview")
  ];
in
{
  keymaps =
    bufdelete
    ++ claudecode
    ++ codecompanion
    ++ conform
    ++ dadbod
    ++ gitbrowse
    ++ neogit
    ++ oil
    ++ picker
    ++ rustaceanvim
    ++ scratch
    ++ terminal
    ++ toggle
    ++ trouble
    ++ typst;
}

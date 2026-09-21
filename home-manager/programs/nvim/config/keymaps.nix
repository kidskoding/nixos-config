let
  normal = key: action: desc: {
    mode = "n";
    inherit key action;
    options.desc = desc;
  };

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

  conform = [
    (normal "<leader>cf" "<cmd>lua require('conform').format({ lsp_format = 'fallback' })<CR>"
      "Format buffer"
    )
  ];

  typst = [
    (normal "<leader>tp" "<cmd>TypstPreviewToggle<CR>" "Toggle Typst preview")
  ];

  neogit = [
    (normal "<leader>gg" "<cmd>Neogit<CR>" "Git status")
  ];

  oil = [
    (normal "-" "<cmd>Oil<CR>" "Browse parent directory")
  ];

  snacks = [
    (normal "<leader><space>" "<cmd>lua Snacks.picker.files()<CR>" "Find files")
    (normal "<leader>ff" "<cmd>lua Snacks.picker.files()<CR>" "Find files")
    (normal "<leader>/" "<cmd>lua Snacks.picker.grep()<CR>" "Search project")
    (normal "<leader>bb" "<cmd>lua Snacks.picker.buffers()<CR>" "Switch buffer")
    (normal "<leader>e" "<cmd>lua Snacks.picker.explorer()<CR>" "File explorer")

    (normal "gd" "<cmd>lua Snacks.picker.lsp_definitions()<CR>" "Go to definition")
    (normal "gD" "<cmd>lua Snacks.picker.lsp_declarations()<CR>" "Go to declaration")
    (normal "gr" "<cmd>lua Snacks.picker.lsp_references()<CR>" "References")
    (normal "gI" "<cmd>lua Snacks.picker.lsp_implementations()<CR>" "Go to implementation")
    (normal "gy" "<cmd>lua Snacks.picker.lsp_type_definitions()<CR>" "Go to type definition")
    (normal "<leader>S" "<cmd>lua Snacks.scratch()<CR>" "Scratch buffer")
    (normal "<leader>Ss" "<cmd>lua Snacks.scratch.select()<CR>" "Select scratch buffer")

    (normal "<leader>gB" "<cmd>lua Snacks.gitbrowse()<CR>" "Open file on GitHub")

    (normal "<leader>ts" "<cmd>lua Snacks.toggle.option('spell')<CR>" "Toggle spell")
    (normal "<leader>tw" "<cmd>lua Snacks.toggle.option('wrap')<CR>" "Toggle wrap")
    (normal "<leader>ti" "<cmd>lua Snacks.toggle.inlay_hints()<CR>" "Toggle inlay hints")

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

  trouble = [
    (normal "<leader>cd" "<cmd>Trouble diagnostics toggle filter.buf=0<CR>" "Buffer diagnostics")
    (normal "<leader>cs" "<cmd>Trouble symbols toggle focus=false<CR>" "Symbols")
    (normal "<leader>cl" "<cmd>Trouble lsp toggle focus=false win.position=right<CR>"
      "LSP definitions / references"
    )
    (normal "<leader>xq" "<cmd>Trouble qflist toggle<CR>" "Quickfix list")
    (normal "<leader>xl" "<cmd>Trouble loclist toggle<CR>" "Location list")
  ];
in
{
  keymaps = claudecode ++ codecompanion ++ conform ++ typst ++ neogit ++ oil ++ snacks ++ trouble;
}

{
  globals = {
    db_ui_use_nerd_fonts = 1;
    db_ui_show_database_icon = 1;
    db_ui_win_position = "left";
    db_ui_winwidth = 40;
    db_ui_execute_on_save = 0;
  };

  highlightOverride = {
    lualine_sep_color_b = {
      fg = "#a89984";
      bg = "#504945";
    };
    lualine_sep_color_x = {
      fg = "#a89984";
      bg = "#3c3836";
    };
  };

  plugins = {
    auto-save = {
      enable = true;
      settings.debounce_delay = 1000;
    };

    conform-nvim = {
      enable = true;

      settings = {
        formatters_by_ft = {
          nix = [ "nixfmt" ];
          lua = [ "stylua" ];
          python = [ "ruff_format" ];
          typst = [ "typstyle" ];
        };
      };
    };

    cord = {
      enable = true;

      settings = {
        variables = true;

        text = {
          viewing = "eyeing up \${filename}";
          editing = "actively cooking in \${filename}";
          workspace = "locked in: \${workspace}";
        };

        editor.tooltip = "not vscode lmao";
        idle.details = "currently touching grass";
      };
    };

    gitsigns.enable = true;
    guess-indent.enable = true;
    render-markdown.enable = true;

    lualine = {
      enable = true;

      settings.options = {
        component_separators = {
          left = "%#lualine_sep_color_b#│";
          right = "%#lualine_sep_color_x#│";
        };
        section_separators = {
          left = "";
          right = "";
        };

        # a patch of the current default lualine gruvbox theme!
        #
        # patch edits:
        # normal mode: background is gruvbox yellow!
        # modes that aren't normal mode inherit the bg color of section c!
        theme.__raw = ''
          (function()
            local t = require("lualine.themes.gruvbox_dark")
            for _, section in pairs(t) do
              section.c = t.normal.c
            end

            t.normal.a.bg = "#d79921"
            return t
          end)()
        '';
      };
    };

    neogit.enable = true;
    nvim-autopairs.enable = true;

    oil = {
      enable = true;
      settings.win_options.cursorline = true;
    };

    rustaceanvim = {
      enable = true;

      settings.server.default_settings.rust-analyzer = {
        cargo.allFeatures = true;
        check.command = "clippy";
      };
    };

    snacks = {
      enable = true;

      settings = {
        bigfile.enabled = true;
        bufdelete.enabled = true;

        dashboard = {
          enabled = false;

          sections = [
            { section = "header"; }
            {
              section = "keys";
              gap = 1;
              padding = 1;
            }
          ];
        };

        gitbrowse.enabled = true;
        indent.enabled = true;
        picker.enabled = true;
        quickfile.enabled = true;
        scratch.enabled = true;
        terminal.enabled = true;
        toggle.enabled = true;
      };
    };

    treesitter = {
      enable = true;
      highlight.enable = true;
      indent.enable = true;
      settings.ensure_installed = [ "typst" ];
    };

    typst-preview = {
      enable = true;
      autoLoad = true;
    };

    trouble.enable = true;

    vim-dadbod.enable = true;
    vim-dadbod-completion.enable = true;
    vim-dadbod-ui.enable = true;

    which-key.enable = true;
  };
}

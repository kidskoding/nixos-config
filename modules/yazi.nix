{
  flake.homeModules.base = {
    config,
    pkgs,
    ...
  }: {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
      shellWrapperName = "y";

      plugins = {
        full-border = pkgs.yaziPlugins.full-border;
        git = pkgs.yaziPlugins.git;
        smart-enter = pkgs.yaziPlugins.smart-enter;
        toggle-pane = pkgs.yaziPlugins.toggle-pane;
      };

      initLua = ''
        require("full-border"):setup()
        require("git"):setup()
      '';

      settings = {
        mgr = {
          show_hidden = true;
          sort_by = "mtime";
          sort_dir_first = true;
          linemode = "size";
          ratio = [0 1 1];
        };
        preview = {
          max_width = 1000;
          max_height = 1000;
        };
        plugin.prepend_fetchers = [
          {
            url = "*";
            run = "git";
            group = "git";
          }
          {
            url = "*/";
            run = "git";
            group = "git";
          }
        ];
      };

      keymap.mgr.prepend_keymap = [
        {
          on = "l";
          run = "plugin smart-enter";
          desc = "Enter the child directory, or open the file";
        }
        {
          on = "<Enter>";
          run = "plugin smart-enter";
          desc = "Enter the child directory, or open the file";
        }
        {
          on = "T";
          run = "plugin toggle-pane max-preview";
          desc = "Maximize or restore the preview pane";
        }
        {
          on = ["g" "n"];
          run = "cd ${config.my.flakeDir}";
          desc = "Go to the nixos config";
        }
        {
          on = ["g" "D"];
          run = "cd ~/Documents";
          desc = "Go to documents";
        }
        {
          on = ["g" "P"];
          run = "cd ~/Pictures";
          desc = "Go to pictures";
        }
        {
          on = ["g" "p"];
          run = "cd ~/playground";
          desc = "Go to playground";
        }
        {
          on = ["g" "u"];
          run = "cd ~/uiuc";
          desc = "Go to uiuc";
        }
        {
          on = ["g" "v"];
          run = "cd ~/vaults";
          desc = "Go to vaults";
        }
        {
          on = ["g" "a"];
          run = "cd ~/anikonistack";
          desc = "Go to anikonistack";
        }
      ];
    };
  };
}

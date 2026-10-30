{...}: {
  flake.homeModules.base = {
    programs.lazygit = {
      enable = true;

      settings = {
        gui = {
          nerdFontsVersion = "3";
          border = "rounded";
          showRandomTip = false;
          showPanelJumps = false;
          expandFocusedSidePanel = true;
        };

        git = {
          overrideGpg = true;
          parseEmoji = true;
          log.showGraph = "always";

          diffRenderers = [
            {
              name = "difftastic";
              type = "extDiff";
              command = "difft --color=always --context={{diffContext}}";
            }
            {
              name = "default";
              type = "rawGit";
            }
          ];
        };

        os.editPreset = "nvim-remote";
        update.method = "never";
      };
    };
  };
}

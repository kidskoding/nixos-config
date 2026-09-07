{ config, ... }:

{
  programs.zellij = {
    enable = true;
    enableFishIntegration = false;

    layouts.default = ''
      layout {
          default_tab_template {
              pane size=1 borderless=true {
                  plugin location="zellij:compact-bar"
              }
              children
          }
      }
    '';

    settings = {
      copy_command = "wl-copy";
      show_startup_tips = false;
      theme = config.theme.name;

      keybinds = {
        unbind = [
          "Ctrl g"
          "Ctrl p"
          "Ctrl n"
          "Ctrl t"
          "Ctrl s"
          "Ctrl o"
          "Ctrl h"
          "Ctrl b"
          "Ctrl q"
        ];

        normal = {
          "bind \"Alt x\"" = { CloseFocus = [ ]; };
          "bind \"Alt s\"" = { NewPane = "stacked"; };
          "bind \"Alt n\"" = { NewPane = "right"; };
          "bind \"Alt t\"" = { NewTab = [ ]; };
        };
      };
    };
  };
}

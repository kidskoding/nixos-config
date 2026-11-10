{...}: {
  flake.homeModules.base = {
    programs.zellij = {
      enable = true;

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
        pane_frame_style = "full";
        stacked_pane_list = false;

        keybinds = {
          unbind = [
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
            "bind \"Ctrl g\"" = {
              SwitchToMode = "Tmux";
            };
          };

          tmux = {
            "bind \"x\"" = {
              CloseFocus = [];
            };
            "bind \"s\"" = {
              NewPane = "stacked";
            };
            "bind \"n\"" = {
              NewPane = "right";
            };
            "bind \"d\"" = {
              NewPane = "down";
            };
            "bind \"t\"" = {
              NewTab = [];
            };
            "bind \"f\"" = {
              ToggleFocusFullscreen = [];
            };
            "bind \"w\"" = {
              ToggleFloatingPanes = [];
            };
            "bind \"m\"" = {
              _children = [
                {Resize = "Decrease";}
                {MovePane = "right";}
              ];
            };

            "bind \"H\"" = {
              MovePane = "left";
            };
            "bind \"J\"" = {
              MovePane = "down";
            };
            "bind \"K\"" = {
              MovePane = "up";
            };
            "bind \"L\"" = {
              MovePane = "right";
            };
            "bind \"b\"" = {
              BreakPane = [];
            };
            "bind \"u\"" = {
              NextSwapLayout = [];
            };

            "bind \"1\"" = {GoToTab = 1;};
            "bind \"2\"" = {GoToTab = 2;};
            "bind \"3\"" = {GoToTab = 3;};
            "bind \"4\"" = {GoToTab = 4;};
            "bind \"5\"" = {GoToTab = 5;};
            "bind \"6\"" = {GoToTab = 6;};
            "bind \"7\"" = {GoToTab = 7;};
            "bind \"8\"" = {GoToTab = 8;};
            "bind \"9\"" = {GoToTab = 9;};
            "bind \"r\"" = {
              _children = [
                {SwitchToMode = "RenameTab";}
                {TabNameInput = 0;}
              ];
            };

            "bind \"v\"" = {
              SwitchToMode = "Scroll";
            };
            "bind \"e\"" = {
              EditScrollback = [];
            };

            "bind \"S\"" = {
              LaunchOrFocusPlugin = {
                _args = ["session-manager"];
                floating = true;
                move_to_focused_tab = true;
              };
            };
            "bind \"q\"" = {
              Detach = [];
            };
            "bind \"Q\"" = {
              Quit = [];
            };

            "bind \"h\"" = {
              MoveFocus = "Left";
            };
            "bind \"l\"" = {
              MoveFocus = "Right";
            };

            "bind \"Left\"" = {
              MoveFocus = "Left";
            };
            "bind \"Right\"" = {
              MoveFocus = "Right";
            };
            "bind \"k\"" = {
              MoveFocus = "Up";
            };
            "bind \"Down\"" = {
              MoveFocus = "Down";
            };
            "bind \"Up\"" = {
              MoveFocus = "Up";
            };

            "bind \"P\"" = {
              GoToPreviousTab = [];
            };
            "bind \"N\"" = {
              GoToNextTab = [];
            };
          };
        };
      };
    };
  };
}

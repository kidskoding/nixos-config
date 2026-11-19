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
            "Alt h"
            "Alt j"
            "Alt k"
            "Alt l"
            "Alt Left"
            "Alt Down"
            "Alt Up"
            "Alt Right"
            "Alt n"
            "Alt f"
            "Alt i"
            "Alt o"
            "Alt p"
            "Alt Shift p"
            "Alt c"
            "Alt ["
            "Alt ]"
            "Alt ="
            "Alt +"
            "Alt -"
          ];

          normal = {
            "bind \"Alt g\"" = {
              SwitchToMode = "Tmux";
            };
          };

          tmux = {
            "bind \"x\"" = {
              CloseFocus = [];
              SwitchToMode = "Normal";
            };
            "bind \"s\"" = {
              NewPane = "stacked";
              SwitchToMode = "Normal";
            };
            "bind \"n\"" = {
              NewPane = "right";
              SwitchToMode = "Normal";
            };
            "bind \"d\"" = {
              NewPane = "down";
              SwitchToMode = "Normal";
            };
            "bind \"t\"" = {
              NewTab = [];
              SwitchToMode = "Normal";
            };
            "bind \"f\"" = {
              ToggleFocusFullscreen = [];
              SwitchToMode = "Normal";
            };
            "bind \"w\"" = {
              ToggleFloatingPanes = [];
              SwitchToMode = "Normal";
            };
            "bind \"m\"" = {
              _children = [
                {Resize = "Decrease";}
                {MovePane = "right";}
              ];
            };

            "bind \"H\"" = {
              GoToPreviousTab = [];
            };
            "bind \"J\"" = {
              MovePane = "down";
            };
            "bind \"K\"" = {
              MovePane = "up";
            };
            "bind \"L\"" = {
              GoToNextTab = [];
            };
            "bind \"b\"" = {
              BreakPane = [];
              SwitchToMode = "Normal";
            };
            "bind \"u\"" = {
              NextSwapLayout = [];
            };

            "bind \"1\"" = {
              GoToTab = 1;
            };
            "bind \"2\"" = {
              GoToTab = 2;
            };
            "bind \"3\"" = {
              GoToTab = 3;
            };
            "bind \"4\"" = {
              GoToTab = 4;
            };
            "bind \"5\"" = {
              GoToTab = 5;
            };
            "bind \"6\"" = {
              GoToTab = 6;
            };
            "bind \"7\"" = {
              GoToTab = 7;
            };
            "bind \"8\"" = {
              GoToTab = 8;
            };
            "bind \"9\"" = {
              GoToTab = 9;
            };
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
              SwitchToMode = "Normal";
            };

            "bind \"S\"" = {
              LaunchOrFocusPlugin = {
                _args = ["session-manager"];
                floating = true;
                move_to_focused_tab = true;
              };
              SwitchToMode = "Normal";
            };
            "bind \"q\"" = {
              Detach = [];
              SwitchToMode = "Normal";
            };
            "bind \"Q\"" = {
              Quit = [];
              SwitchToMode = "Normal";
            };

            "bind \"h\"" = {
              MoveFocus = "Left";
            };
            "bind \"j\"" = {
              MoveFocus = "Down";
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
          };
        };
      };
    };
  };
}

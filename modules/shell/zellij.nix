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
                {SwitchToMode = "Normal";}
              ];
            };

            "bind \"H\"" = {
              GoToPreviousTab = [];
              SwitchToMode = "Normal";
            };
            "bind \"J\"" = {
              MovePane = "down";
              SwitchToMode = "Normal";
            };
            "bind \"K\"" = {
              MovePane = "up";
              SwitchToMode = "Normal";
            };
            "bind \"L\"" = {
              GoToNextTab = [];
              SwitchToMode = "Normal";
            };
            "bind \"b\"" = {
              BreakPane = [];
              SwitchToMode = "Normal";
            };
            "bind \"u\"" = {
              NextSwapLayout = [];
              SwitchToMode = "Normal";
            };

            "bind \"1\"" = {
              GoToTab = 1;
              SwitchToMode = "Normal";
            };
            "bind \"2\"" = {
              GoToTab = 2;
              SwitchToMode = "Normal";
            };
            "bind \"3\"" = {
              GoToTab = 3;
              SwitchToMode = "Normal";
            };
            "bind \"4\"" = {
              GoToTab = 4;
              SwitchToMode = "Normal";
            };
            "bind \"5\"" = {
              GoToTab = 5;
              SwitchToMode = "Normal";
            };
            "bind \"6\"" = {
              GoToTab = 6;
              SwitchToMode = "Normal";
            };
            "bind \"7\"" = {
              GoToTab = 7;
              SwitchToMode = "Normal";
            };
            "bind \"8\"" = {
              GoToTab = 8;
              SwitchToMode = "Normal";
            };
            "bind \"9\"" = {
              GoToTab = 9;
              SwitchToMode = "Normal";
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
              SwitchToMode = "Normal";
            };
            "bind \"j\"" = {
              MoveFocus = "Down";
              SwitchToMode = "Normal";
            };
            "bind \"l\"" = {
              MoveFocus = "Right";
              SwitchToMode = "Normal";
            };

            "bind \"Left\"" = {
              MoveFocus = "Left";
              SwitchToMode = "Normal";
            };
            "bind \"Right\"" = {
              MoveFocus = "Right";
              SwitchToMode = "Normal";
            };
            "bind \"k\"" = {
              MoveFocus = "Up";
              SwitchToMode = "Normal";
            };
            "bind \"Down\"" = {
              MoveFocus = "Down";
              SwitchToMode = "Normal";
            };
            "bind \"Up\"" = {
              MoveFocus = "Up";
              SwitchToMode = "Normal";
            };
          };
        };
      };
    };
  };
}

{...}: {
  flake.homeModules.base = {
    programs.zellij = {
      enable = true;
      enableFishIntegration = true;

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
            "bind \"Alt x\"" = {
              CloseFocus = [];
            };
            "bind \"Alt s\"" = {
              NewPane = "stacked";
            };
            "bind \"Alt n\"" = {
              NewPane = "right";
            };
            "bind \"Alt d\"" = {
              NewPane = "down";
            };
            "bind \"Alt t\"" = {
              NewTab = [];
            };
            "bind \"Alt f\"" = {
              ToggleFocusFullscreen = [];
            };
            "bind \"Alt w\"" = {
              ToggleFloatingPanes = [];
            };
            "bind \"Alt m\"" = {
              _children = [
                {Resize = "Decrease";}
                {MovePane = "right";}
              ];
            };

            "bind \"Ctrl Alt h\"" = {
              MovePane = "left";
            };
            "bind \"Ctrl Alt j\"" = {
              MovePane = "down";
            };
            "bind \"Ctrl Alt k\"" = {
              MovePane = "up";
            };
            "bind \"Ctrl Alt l\"" = {
              MovePane = "right";
            };
            "bind \"Alt b\"" = {
              BreakPane = [];
            };
            "bind \"Alt u\"" = {
              NextSwapLayout = [];
            };

            "bind \"Alt 1\"" = {GoToTab = 1;};
            "bind \"Alt 2\"" = {GoToTab = 2;};
            "bind \"Alt 3\"" = {GoToTab = 3;};
            "bind \"Alt 4\"" = {GoToTab = 4;};
            "bind \"Alt 5\"" = {GoToTab = 5;};
            "bind \"Alt 6\"" = {GoToTab = 6;};
            "bind \"Alt 7\"" = {GoToTab = 7;};
            "bind \"Alt 8\"" = {GoToTab = 8;};
            "bind \"Alt 9\"" = {GoToTab = 9;};
            "bind \"Alt r\"" = {
              _children = [
                {SwitchToMode = "RenameTab";}
                {TabNameInput = 0;}
              ];
            };

            "bind \"Alt v\"" = {
              SwitchToMode = "Scroll";
            };
            "bind \"Alt e\"" = {
              EditScrollback = [];
            };

            "bind \"Alt S\" \"Alt Shift s\"" = {
              LaunchOrFocusPlugin = {
                _args = ["session-manager"];
                floating = true;
                move_to_focused_tab = true;
              };
            };
            "bind \"Alt q\"" = {
              Detach = [];
            };
            "bind \"Alt Q\" \"Alt Shift q\"" = {
              Quit = [];
            };

            # Lock passes every key through to the app, for programs or nested
            # sessions that need Alt.
            "bind \"Alt g\"" = {
              SwitchToMode = "Locked";
            };

            "bind \"Alt h\" \"Alt Left\"" = {
              MoveFocus = "Left";
            };
            "bind \"Alt l\" \"Alt Right\"" = {
              MoveFocus = "Right";
            };

            "bind \"Alt H\" \"Alt Shift h\" \"Alt K\" \"Alt Shift k\" \"Alt Shift Left\" \"Alt Shift Up\"" = {
              GoToPreviousTab = [];
            };
            "bind \"Alt L\" \"Alt Shift l\" \"Alt J\" \"Alt Shift j\" \"Alt Shift Right\" \"Alt Shift Down\"" = {
              GoToNextTab = [];
            };
          };

          locked = {
            "bind \"Alt g\"" = {
              SwitchToMode = "Normal";
            };
          };
        };
      };
    };
  };
}

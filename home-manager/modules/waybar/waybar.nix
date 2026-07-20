{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    settings = [{
      layer = "top";
      position = "top";
      height = 38;
      spacing = 0;
      "margin-top" = 4;
      "margin-left" = 4;
      "margin-right" = 4;

      "modules-left" = [ "hyprland/workspaces" ];
      "modules-center" = [
        "custom/spotify-icon"
        "custom/spotify-playstate"
        "custom/spotify-text"
      ];
      "modules-right" = [
        "pulseaudio"
        "network"
        "backlight"
        "battery"
        "clock#date"
        "clock#time"
      ];

      "hyprland/workspaces" = {
        format = "{id}";
        "on-click" = "activate";
        "all-outputs" = true;
        "sort-by-number" = true;
      };

      pulseaudio = {
        format = "<span color='${config.theme.colors.greenBright}'>{icon}</span> {volume}%";
        "format-muted" = "<span color='${config.theme.colors.redBright}'>󰝟</span> muted";
        "format-icons"."default" = [ "󰕿" "󰖀" "󰕾" ];
        "on-click" = "pavucontrol";
      };

      network = {
        "format-wifi" = "<span color='${config.theme.colors.blueBright}'>󰖩 </span> {essid}";
        "format-ethernet" = "<span color='${config.theme.colors.blueBright}'>󰈀 </span> {ifname}";
        "format-disconnected" = "<span color='${config.theme.colors.redBright}'>󰤮 </span> disconnected";
        interval = 5;
      };

      backlight = {
        device = "intel_backlight";
        format = "<span color='${config.theme.colors.yellowBright}'>{icon} </span> {percent}%";
        "format-icons" = [ "󰃞" "󰃟" "󰃠" ];
      };

      battery = {
        bat = "BAT0";
        adapter = "ADP1";
        "full-at" = 99;
        interval = 5;
        states = {
          good = 80;
          warning = 30;
          critical = 15;
        };
        format = "<span color='${config.theme.colors.greenBright}'>{icon}</span> {capacity}%";
        "format-charging" = "<span color='${config.theme.colors.greenBright}'>󰂄</span> {capacity}%";
        "format-plugged" = "<span color='${config.theme.colors.greenBright}'>󰚥</span> {capacity}%";
        "format-full" = "<span color='${config.theme.colors.greenBright}'>󰁹</span> {capacity}%";
        "format-good" = "<span color='${config.theme.colors.greenBright}'>{icon}</span> {capacity}%";
        "format-warning" = "<span color='${config.theme.colors.yellowBright}'>{icon}</span> {capacity}%";
        "format-critical" = "<span color='${config.theme.colors.redBright}'>{icon}</span> {capacity}%";
        "format-icons" = [ "󰁺" "󰁼" "󰁾" "󰂀" "󰁹" ];
      };

      "clock#date" = {
        interval = 60;
        format = "<span color='${config.theme.colors.yellowBright}'>󰃭 </span> {:%a %b %d}";
        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      "clock#time" = {
        interval = 1;
        format = "<span color='${config.theme.colors.yellowBright}'>󰥔 </span> {:%I:%M %p}";
        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      "custom/spotify-icon" = {
        format = "<span color='${config.theme.colors.greenBright}'> </span>";
        tooltip = false;
      };

      "custom/spotify-playstate" = {
        format = "{icon}";
        "return-type" = "json";
        "format-icons" = {
          Playing = " ";
          Paused = " ";
        };
        "exec-if" = "pgrep -f spotify-wrapped";
        exec = "playerctl -p spotify metadata --format '{\"alt\": \"{{status}}\"}' -F";
        "on-click" = "playerctl -p spotify play-pause";
        tooltip = false;
      };

      "custom/spotify-text" = {
        format = "{}";
        exec = "${config.home.homeDirectory}/.config/waybar/scripts/scroll.sh";
        "exec-if" = "pgrep -f spotify-wrapped";
        "on-click" = "playerctl -p spotify play-pause";
        escape = true;
      };
    }];

    style = builtins.replaceStrings
      [ "@font-family@" "@color-bg@" "@color-bg-alt@" "@color-fg@" "@color-yellow@" "@color-red@" "@color-aqua@" "@color-green@" "@color-gray@" "@color-gray-rgb@" ]
      [ config.theme.fontFamily config.theme.colors.bg config.theme.colors.bgAlt config.theme.colors.fg config.theme.colors.yellowBright config.theme.colors.redBright config.theme.colors.aquaBright config.theme.colors.greenBright config.theme.colors.gray config.theme.rgb.gray ]
      (builtins.readFile ./style.css);
  };

  home.file.".config/waybar/scripts/scroll.sh" = {
    source = ./scripts/scroll.sh;
    executable = true;
  };

  home.file.".config/waybar/scripts/spotify-launcher.sh" = {
    source = ./scripts/spotify-launcher.sh;
    executable = true;
  };
}

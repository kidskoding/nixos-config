{ config, inputs, pkgs, ... }:

let
  c = config.theme.colors;
in
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia-shell = {
    enable = true;

    colors = {
      mPrimary = c.yellowBright;
      mOnPrimary = c.bg;

      mSecondary = c.purple;
      mOnSecondary = c.bg;

      mTertiary = c.greenBright;
      mOnTertiary = c.bg;

      mError = c.redBright;
      mOnError = c.bg;

      mSurface = c.bg;
      mOnSurface = c.fg;

      mSurfaceVariant = c.bgAlt;
      mOnSurfaceVariant = c.gray;

      mOutline = c.bgAlt;
      mShadow = c.black;

      mHover = c.fg;
      mOnHover = c.bg;
    };

    settings = {
      settingsVersion = 59;

      colorSchemes = {
        useWallpaperColors = false;
        predefinedScheme = "";
        darkMode = true;
      };

      general.dimmerOpacity = 0.0;
      general.avatarImage = "${./avatar.jpg}";
      ui.fontDefault = config.theme.fontFamily;
      ui.fontFixed = config.theme.fontFamily;

      bar = {
        position = "top";
        barType = "floating";
        marginVertical = 6;
        marginHorizontal = 8;
        contentPadding = 8;
        widgetSpacing = 8;
        useSeparateOpacity = true;
        backgroundOpacity = 0.85;
        rightClickAction = "none";

        widgets = {
          left = [
            {
              id = "Workspace";
              labelMode = "index";
              emptyColor = "none";
              hideUnoccupied = true;
            }
          ];
          center = [
            {
              id = "MediaMini";
              maxWidth = 300;
              scrollingMode = "always";
              useFixedWidth = false;
            }
          ];
          right = [
            { id = "Tray"; }
            { id = "Volume"; displayMode = "alwaysShow"; }
            { id = "Network"; displayMode = "alwaysShow"; }
            { id = "Brightness"; displayMode = "alwaysShow"; }
            { id = "Battery"; displayMode = "icon-always"; }
            {
              id = "Clock";
              formatHorizontal = "ddd MMM dd  hh:mm AP";
              tooltipFormat = "dddd, MMMM d yyyy";
            }
            { id = "ControlCenter"; }
          ];
        };
      };

      location.useFahrenheit = true;
      location.autoLocate = true;
      location.use12hourFormat = true;

      notifications = {
        location = "top_right";
        density = "compact";
        lowUrgencyDuration = 10;
        normalUrgencyDuration = 10;
        criticalUrgencyDuration = 60;
      };

      appLauncher = {
        position = "center";
        terminalCommand = "alacritty -e";
        enableClipboardHistory = true;
      };

      audio = {
        volumeStep = 5;
        preferredPlayer = "spotify";
      };

      brightness.brightnessStep = 5;

      systemMonitor = {
        batteryWarningThreshold = 30;
        batteryCriticalThreshold = 15;
      };

      wallpaper.enabled = false;
      dock.enabled = false;
    };
  };
}

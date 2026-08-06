{ config, ... }:

let
  c = config.theme.colors;
in
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    attachExistingSession = true;

    settings = {
      theme = "custom";
      pane_frames = false;
      copy_command = "wl-copy";
      show_startup_tips = false;

      keybinds.normal = {
        "bind \"Alt d\"" = { CloseFocus = [ ]; };
        "bind \"Alt s\"" = { NewPane = "stacked"; };
        "bind \"Alt t\"" = { NewTab = [ ]; };
      };

      themes.custom = {
        fg = c.fg;
        bg = c.bg;
        black = c.black;
        red = c.red;
        green = c.green;
        yellow = c.yellow;
        blue = c.blue;
        magenta = c.purple;
        cyan = c.aqua;
        white = c.gray;
        orange = c.yellowBright;
      };
    };
  };
}

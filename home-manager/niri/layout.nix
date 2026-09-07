{ config, ... }:

{
  programs.niri.settings.layout = {
    gaps = 10;

    center-focused-column = "on-overflow";
    default-column-width.proportion = 0.5;
    preset-column-widths = [
      { proportion = 0.33333; }
      { proportion = 0.5; }
      { proportion = 0.66667; }
      { proportion = 1.0; }
    ];

    focus-ring.enable = false;

    border = {
      enable = true;
      width = 2;
      # gruvbox.nix defaults the active border to the accent; i like purple here
      active.color = config.gruvbox.palette.purple;
    };

    shadow = {
      enable = true;
      softness = 20;
    };
  };
}

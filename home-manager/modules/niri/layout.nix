{ config, ... }:

let
  c = config.theme.colors;
in
{
  programs.niri.settings.layout = {
    gaps = 10;
    background-color = c.bg;

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
      active.color = c.purple;
      inactive.color = c.bgAlt;
    };

    shadow = {
      enable = true;
      softness = 20;
      color = "${c.black}ee";
    };
  };
}

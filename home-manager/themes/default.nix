{ config, lib, ... }:

let
  hexDigit = {
    "0" = 0; "1" = 1; "2" = 2; "3" = 3; "4" = 4;
    "5" = 5; "6" = 6; "7" = 7; "8" = 8; "9" = 9;
    a = 10; b = 11; c = 12; d = 13; e = 14; f = 15;
    A = 10; B = 11; C = 12; D = 13; E = 14; F = 15;
  };

  hexByteToInt = s: (hexDigit.${builtins.substring 0 1 s}) * 16 + hexDigit.${builtins.substring 1 1 s};

  hexToRgb = sep: hex:
    let
      h = builtins.substring 1 6 hex;
      r = hexByteToInt (builtins.substring 0 2 h);
      g = hexByteToInt (builtins.substring 2 2 h);
      b = hexByteToInt (builtins.substring 4 2 h);
    in
    "${toString r}${sep}${toString g}${sep}${toString b}";

  palette = import (./. + "/${config.theme.name}.nix");
in
{
  options.theme.name = lib.mkOption {
    type = lib.types.str;
    default = "gruvbox-dark";
    description = "active theme, must match a <name>.nix file in this directory.";
  };

  options.theme.fontFamily = lib.mkOption {
    type = lib.types.str;
    default = "Terminess Nerd Font Mono";
    description = "font family i use across my app configs!";
  };

  options.theme.dark = lib.mkOption {
    type = lib.types.bool;
    default = palette.dark;
    description = "whether the active theme is a dark theme.";
  };

  options.theme.colors = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = palette.colors;
    description = "semantic color palette of the active theme, shared across app configs.";
  };

  options.theme.rgb = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = lib.mapAttrs (_: hexToRgb ", ") config.theme.colors;
    description = "theme.colors, but as \"R, G, B\" decimal strings for CSS rgba() use.";
  };

  options.theme.ansi = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = lib.mapAttrs (_: hexToRgb ";") config.theme.colors;
    description = "theme.colors, but as \"R;G;B\" decimal strings for ANSI truecolor escape codes (e.g. fastfetch).";
  };
}

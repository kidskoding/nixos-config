{ config, lib, ... }:

let
  hexDigit = {
    "0" = 0; "1" = 1; "2" = 2; "3" = 3; "4" = 4;
    "5" = 5; "6" = 6; "7" = 7; "8" = 8; "9" = 9;
    a = 10; b = 11; c = 12; d = 13; e = 14; f = 15;
    A = 10; B = 11; C = 12; D = 13; E = 14; F = 15;
  };

  hexByteToInt = s: (hexDigit.${builtins.substring 0 1 s}) * 16 + hexDigit.${builtins.substring 1 1 s};
  hexDigitChars = "0123456789abcdef";
  intToHexByte = n:
    "${builtins.substring (n / 16) 1 hexDigitChars}${builtins.substring (builtins.bitAnd n 15) 1 hexDigitChars}";

  hexToRgbInts = hex:
    let h = builtins.substring 1 6 hex; in {
      r = hexByteToInt (builtins.substring 0 2 h);
      g = hexByteToInt (builtins.substring 2 2 h);
      b = hexByteToInt (builtins.substring 4 2 h);
    };

  hexToRgb = sep: hex:
    let c = hexToRgbInts hex; in
    "${toString c.r}${sep}${toString c.g}${sep}${toString c.b}";

  # bump every channel of a hex color by `amount` (clamped to 255). this is used to derive an
  # elevated "surface" shade from the base background, since terminal palettes don't have one
  lighten = hex: amount:
    let
      c = hexToRgbInts hex;
      clamp = n: if n > 255 then 255 else n;
      bump = ch: clamp (ch + amount);
    in "#${intToHexByte (bump c.r)}${intToHexByte (bump c.g)}${intToHexByte (bump c.b)}";
in
{
  options.theme.name = lib.mkOption {
    type = lib.types.str;
    default = "catppuccin-mocha";
    description = "active theme, must match a <name>.toml file in this directory.";
  };

  options.theme.colors = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default =
      let
        palette = (builtins.fromTOML (builtins.readFile (./. + "/${config.theme.name}.toml"))).colors;
      in {
        bg = palette.primary.background;
        bgAlt = lighten palette.primary.background 20;
        fg = palette.primary.foreground;

        black = palette.normal.black;
        red = palette.normal.red;
        green = palette.normal.green;
        yellow = palette.normal.yellow;
        blue = palette.normal.blue;
        purple = palette.normal.magenta;
        aqua = palette.normal.cyan;
        gray = palette.normal.white;

        grayBright = palette.bright.black;
        redBright = palette.bright.red;
        greenBright = palette.bright.green;
        yellowBright = palette.bright.yellow;
        blueBright = palette.bright.blue;
        purpleBright = palette.bright.magenta;
        aquaBright = palette.bright.cyan;
        fgBright = palette.bright.white;
      };
    description = "semantic color palette derived from the active theme's alacritty toml, shared across app configs.";
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

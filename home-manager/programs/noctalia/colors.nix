{
  config,
  lib,
  ...
}: let
  c = config.lib.stylix.colors.withHashtag;
  capitalize = s: lib.toUpper (builtins.substring 0 1 s) + builtins.substring 1 (-1) s;
  toPaletteKey = role: "m" + lib.concatMapStrings capitalize (lib.splitString "_" role);

  roles = lib.mapAttrs' (role: lib.nameValuePair (toPaletteKey role)) (import ./palette.nix c);
  palette =
    roles
    // {
      terminal = {
        normal = {
          black = c.base00;
          red = c.base08;
          green = c.base0B;
          yellow = c.base0A;
          blue = c.base0D;
          magenta = c.base0E;
          cyan = c.base0C;
          white = c.base04;
        };
        bright = {
          black = c.base04;
          red = c.base08;
          green = c.base0B;
          yellow = c.base0A;
          blue = c.base0D;
          magenta = c.base0E;
          cyan = c.base0C;
          white = c.base05;
        };
        foreground = c.base05;
        background = c.base00;
        cursor = c.base05;
        cursorText = c.base00;
        selectionFg = c.base00;
        selectionBg = c.base05;
      };
    };
in {
  stylix.targets.noctalia.colors.enable = false;

  programs.noctalia = {
    customPalettes.stylix = {
      dark = palette;
      light = palette;
    };

    settings.theme = {
      mode = config.stylix.polarity;
      source = "custom";
      custom_palette = "stylix";
    };
  };
}

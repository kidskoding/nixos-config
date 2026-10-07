{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (config.evergarden) variant;
  p = inputs.evergarden.lib.palette.${variant};
  capitalize = s: lib.toUpper (builtins.substring 0 1 s) + builtins.substring 1 (-1) s;
in {
  evergarden = {
    variant = "winter";
    accent = "green";
  };

  stylix = {
    enable = true;

    base16Scheme = {
      scheme = "Evergarden ${capitalize variant}";
      author = "comfysage";
      base00 = p.base;
      base01 = p.surface0;
      base02 = p.surface1;
      base03 = p.overlay0;
      base04 = p.subtext0;
      base05 = p.text;
      base06 = p.cherry;
      base07 = p.snow;
      base08 = p.red;
      base09 = p.orange;
      base0A = p.yellow;
      base0B = p.green;
      base0C = p.aqua;
      base0D = p.blue;
      base0E = p.purple;
      base0F = p.pink;
    };
    polarity = "dark";

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.terminess-ttf;
        name = "Terminess Nerd Font Mono";
      };

      sansSerif = config.stylix.fonts.monospace;
      serif = config.stylix.fonts.monospace;
      sizes.terminal = 16;
    };

    cursor = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 32;
    };

    opacity.terminal = 0.8;

    targets.console.enable = false;
    targets.grub.enable = false;
    targets.nixos-icons.enable = false;
    targets.plymouth.enable = false;
  };

  home-manager.users.anirudh.stylix.targets = {
    gnome.enable = false;
    kde.enable = false;
  };
}

{inputs, ...}: let
  common = {
    config,
    lib,
    pkgs,
    ...
  }: let
    nerdFont = {
      package = pkgs.nerd-fonts.googlesanscode;
      family = "GoogleSansCode Nerd Font";
    };
  in {
    stylix = {
      enable = true;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
      override.base05 = "#ebdbb2";
      polarity = "dark";

      fonts = {
        monospace = lib.mkDefault {
          inherit (nerdFont) package;
          name = "${nerdFont.family} Mono";
        };

        sansSerif = lib.mkDefault {
          inherit (nerdFont) package;
          name = "${nerdFont.family} Propo";
        };

        serif = config.stylix.fonts.sansSerif;
        sizes = {
          terminal = lib.mkDefault (builtins.floor (14 * config.my.display.textScale));
          applications = lib.mkDefault 12;
          desktop = lib.mkDefault 11;
          popups = lib.mkDefault 11;
        };
      };

      cursor = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
        size = 32;
      };

      opacity.terminal = 0.8;
      targets.qt.enable = false;
    };
  };
in {
  flake.nixosModules.stylix = {
    lib,
    pkgs,
    ...
  }: {
    imports = [inputs.stylix.nixosModules.stylix common];

    stylix.targets = {
      console.enable = false;
      grub.enable = false;
      nixos-icons.enable = false;
      plymouth.enable = false;
    };

    # keep discord on its own theme, not the stylix palette
    home-manager.sharedModules = [{stylix.targets.vencord.enable = false;}];

    # gruvbox is the default; scripts/theme.sh switches to these prebuilt variants.
    # home-manager follows the system stylix on nixos hosts, so this covers it too.
    specialisation =
      lib.mapAttrs (_: scheme: {
        configuration.stylix = {
          base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/${scheme}.yaml";
          override = lib.mkForce {}; # the base05 override is gruvbox-only
        };
      }) {
        catppuccin = "catppuccin-mocha";
        tokyonight = "tokyo-night-dark";
      };
  };

  flake.homeModules.stylix = {
    imports = [inputs.stylix.homeModules.stylix common];
    stylix.targets.vencord.enable = false;
  };
}

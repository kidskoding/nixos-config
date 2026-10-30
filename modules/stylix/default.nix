{inputs, ...}: let
  common = {
    config,
    lib,
    pkgs,
    ...
  }: let
    nerdFont = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      family = "JetBrainsMono Nerd Font";
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
        sizes.terminal = lib.mkDefault 16;
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
    imports = [inputs.stylix.nixosModules.stylix common];

    stylix.targets = {
      console.enable = false;
      grub.enable = false;
      nixos-icons.enable = false;
      plymouth.enable = false;
    };
  };

  flake.homeModules.stylix = {
    imports = [inputs.stylix.homeModules.stylix common];
  };
}

{inputs, ...}: let
  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "macchiato";
  };

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
    inherit catppuccin;

    stylix = {
      enable = true;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
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

      opacity.terminal = 0.85;
      targets.qt.enable = false;
    };
  };
in {
  flake.nixosModules.stylix = {
    imports = [inputs.stylix.nixosModules.stylix inputs.catppuccin.nixosModules.catppuccin common];

    home-manager.sharedModules = [
      inputs.catppuccin.homeModules.catppuccin
      {inherit catppuccin;}
    ];

    catppuccin = {
      grub.enable = true;
      plymouth.enable = false;
      tty.enable = false;
    };

    stylix.targets = {
      console.enable = false;
      grub.enable = false;
      nixos-icons.enable = false;
      plymouth.enable = false;
    };
  };

  flake.homeModules.stylix = {
    imports = [inputs.stylix.homeModules.stylix inputs.catppuccin.homeModules.catppuccin common];
  };
}

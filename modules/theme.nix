{inputs, ...}: {
  flake.nixosModules.theme = {
    config,
    lib,
    pkgs,
    ...
  }: {
    imports = [
      inputs.stylix.nixosModules.stylix
      inputs.catppuccin.nixosModules.catppuccin
    ];

    home-manager.sharedModules = [inputs.catppuccin.homeModules.catppuccin];

    catppuccin = {
      enable = true;
      autoEnable = true;
      flavor = "macchiato";

      grub.enable = true;
      plymouth.enable = false;
      tty.enable = false;
    };

    stylix = {
      enable = true;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
      polarity = "dark";

      fonts = {
        monospace = lib.mkDefault {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font Mono";
        };

        sansSerif = lib.mkDefault {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font Propo";
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

      targets = {
        console.enable = false;
        grub.enable = false;
        nixos-icons.enable = false;
        plymouth.enable = false;
        qt.enable = false;
      };
    };
  };

  flake.homeModules.base = {
    catppuccin = {
      enable = true;
      autoEnable = true;
      flavor = "macchiato";
      cava.transparent = true;
    };

    # use catppuccin built in ports instead of stylix!
    stylix.targets = {
      cava.enable = false;
      gnome.enable = false;
      kde.enable = false;
      qt.enable = false;
      rofi.enable = false;

      bat.colors.enable = false;
      btop.colors.enable = false;
      fish.colors.enable = false;
      fzf.colors.enable = false;
      ghostty.colors.enable = false;
      helix.colors.enable = false;
      lazygit.colors.enable = false;
      mpv.colors.enable = false;
      opencode.colors.enable = false;
      starship.colors.enable = false;
      yazi.colors.enable = false;
      zellij.colors.enable = false;
    };
  };
}

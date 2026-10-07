{
  config,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
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

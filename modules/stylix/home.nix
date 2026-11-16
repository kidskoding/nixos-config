{...}: {
  flake.homeModules.base = {
    catppuccin.cava.transparent = true;

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
      zellij.colors.enable = false;
    };
  };
}

{
  config,
  pkgs,
  ...
}: let
  hm = config.home-manager.users.anirudh;
  c = config.lib.stylix.colors.withHashtag;
  niri = hm.programs.niri.settings;
  eDP-1 = niri.outputs."eDP-1";
in {
  services.displayManager.noctalia-greeter = {
    enable = true;

    settings = {
      session.default = "Niri";
      user.default = "anirudh";

      appearance = {
        scheme = "Synced";
        theme_mode = "dark";
        hide_logo = false;
        font_family = config.stylix.fonts.monospace.name;

        palette = import ./palette.nix c;

        wallpaper = {
          path = "${../../wallpaper/images/starfire-bg.jpg}";
          fill_mode = "crop";
        };
      };

      output = {
        width = eDP-1.mode.width;
        height = eDP-1.mode.height;
        scale = eDP-1.scale;
      };

      cursor = {
        theme = niri.cursor.theme;
        size = niri.cursor.size;
        path = "${pkgs.adwaita-icon-theme}/share/icons";
      };

      keyboard.layout = niri.input.keyboard.xkb.layout;

      idle.timeout = 330;
    };
  };

  systemd.tmpfiles.settings."10-accountsservice-avatar"."/var/lib/AccountsService/users/anirudh"."f+".argument = "[User]\nIcon=${./avatars/starfire.jpeg}\n";

  fonts.packages = [pkgs.nerd-fonts.terminess-ttf];
}

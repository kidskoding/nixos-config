{
  config,
  pkgs,
  ...
}: let
  hm = config.home-manager.users.anirudh;
  c = hm.theme.colors;
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
        font_family = hm.theme.fontFamily;

        palette = {
          primary = c.yellowBright;
          on_primary = c.bg;

          secondary = c.blueBright;
          on_secondary = c.bg;

          tertiary = c.greenBright;
          on_tertiary = c.bg;

          error = c.redBright;
          on_error = c.bg;

          surface = c.bg;
          on_surface = c.fg;

          surface_variant = c.bgAlt;
          on_surface_variant = c.gray;

          outline = c.bgAlt;
          shadow = c.black;

          hover = c.fg;
          on_hover = c.bg;
        };

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

  systemd.tmpfiles.settings."10-accountsservice-avatar"."/var/lib/AccountsService/users/anirudh"."f+".argument = "[User]\nIcon=${./samus.png}\n";

  fonts.packages = [pkgs.nerd-fonts.terminess-ttf];
}

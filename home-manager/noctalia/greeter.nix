{ config, pkgs, ... }:

let
  hm = config.home-manager.users.anirudh;
  niri = hm.programs.niri.settings;
  eDP-1 = niri.outputs."eDP-1";
in
{
  programs.noctalia-greeter = {
    enable = true;

    settings = {
      session.default = "Niri";
      user.default = "anirudh";

      appearance = {
        hide_logo = false;
        font_family = hm.theme.fontFamily;

        wallpaper = {
          path = "${../wallpaper/images/starfire-bg.jpg}";
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

  fonts.packages = [ pkgs.nerd-fonts.gohufont ];
}

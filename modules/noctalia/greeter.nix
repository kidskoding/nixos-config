{inputs, ...}: {
  flake.nixosModules.noctalia = {config, ...}: {
    imports = [inputs.noctalia-greeter.nixosModules.default];

    # greeter runs as the greeter user before login and cannot read ~/,
    # so its settings and assets go through the store and /etc (needs a rebuild)
    services.displayManager.noctalia-greeter = {
      enable = true;
      settings = {
        user.default = "kidskoding";
        session.default = "Umbriel";

        appearance = {
          scheme = config.my.theme.greeter;
          theme_mode = "dark";
          hide_logo = false;
          font_family = config.stylix.fonts.sansSerif.name;
          wallpaper = {
            path = "/etc/noctalia-greeter/wallpaper.jpg";
            fill_mode = "crop";
          };
        };

        cursor = {
          theme = config.stylix.cursor.name;
          size = config.stylix.cursor.size;
          path = "/run/current-system/sw/share/icons";
        };

        keyboard.layout = "us";
        idle.timeout = 330;

        output = {
          width = config.my.display.width;
          height = config.my.display.height;
          scale = config.my.display.scale;
        };
      };
    };

    environment.etc."noctalia-greeter/wallpaper.jpg".source = ./wallpapers/starfire-bg.jpg;

    systemd.tmpfiles.settings."10-accountsservice-avatar"."/var/lib/AccountsService/users/kidskoding"."f+".argument = "[User]\nIcon=${./avatars/starfire.jpeg}\n";
  };
}

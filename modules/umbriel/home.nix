{...}: {
  flake.homeModules.umbriel = {
    config,
    pkgs,
    ...
  }: let
    dir = "${config.my.flakeDir}/modules/umbriel";
    link = config.lib.file.mkOutOfStoreSymlink;
  in {
    # gui helpers live in nixosModules.umbriel
    home.packages = with pkgs; [
      adwaita-icon-theme
      brightnessctl
      cliphist
      grim
      libnotify
      playerctl
      slurp
      wl-clipboard
      wl-mirror

      kdePackages.qtsvg
    ];

    # user config wins over the system file, so re-point just FileChooser at kde.
    xdg.configFile."xdg-desktop-portal/umbriel-portals.conf".text = ''
      [preferred]
      default=umbriel;gtk;
      org.freedesktop.impl.portal.Access=gtk;
      org.freedesktop.impl.portal.FileChooser=kde;
      org.freedesktop.impl.portal.Notification=gtk;
      org.freedesktop.impl.portal.Secret=gnome-keyring;
    '';

    programs.fish.loginShellInit = ''
      if test (tty) = /dev/tty1; and not set -q UMBRIEL_SESSION_STARTED
        set -gx UMBRIEL_SESSION_STARTED 1
        exec start-umbriel
      end
    '';

    xdg.configFile."umbriel/config.toml".source = link "${dir}/config.toml";

    programs.umbriel.enable = true;
  };
}

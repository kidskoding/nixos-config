{self, ...}: {
  perSystem = {inputs', ...}: {
    packages.noctalia = inputs'.noctalia.packages.default.overrideAttrs (old: {
      patches =
        (old.patches or [])
        ++ [
          ./patches/clock-markup.patch
          ./patches/markup-colors.patch
          ./patches/volume-icon-state.patch
          ./patches/audio-osd-muted-colors.patch
          ./patches/brightness-osd-color.patch
          ./patches/control-center-power-button.patch
          ./patches/battery-icon-thresholds.patch
          ./patches/lockscreen-login-clock.patch
          ./patches/lockscreen-battery-status.patch
          ./patches/lockscreen-header-caps-lock.patch
          ./patches/lockscreen-header-user.patch
          ./patches/media-player-seek-bar.patch
          ./patches/solid-panels.patch
          ./patches/network-wifi-off-color.patch
          ./patches/bluetooth-off-color.patch
          ./patches/theme-terminal-colors.patch
          ./patches/panel-close-button-red.patch
          ./patches/marquee-gap.patch
          ./patches/destructive-button-hover.patch
          ./patches/headphones-volume-icon.patch
        ];
    });
  };

  flake.nixosModules.noctalia = {
    config,
    inputs,
    lib,
    pkgs,
    ...
  }: {
    imports = [inputs.noctalia-greeter.nixosModules.default];

    # greeter runs as the greeter user before login and cannot read ~/,
    # so its toml and assets go through the store and /etc (needs a rebuild)
    services.displayManager.noctalia-greeter = {
      enable = true;
      settings = lib.recursiveUpdate (lib.importTOML ./greeter/greeter.toml) {
        user.default = "kidskoding";
        appearance.font_family = config.stylix.fonts.sansSerif.name;
        output = {inherit (config.my.display) width height scale;};
      };
    };

    environment.etc."noctalia-greeter/wallpaper.jpg".source = ./wallpapers/starfire-bg.jpg;

    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.noctalia
      pkgs.adwaita-icon-theme
    ];

    systemd.tmpfiles.settings."10-accountsservice-avatar"."/var/lib/AccountsService/users/kidskoding"."f+".argument = "[User]\nIcon=${./avatars/starfire.jpeg}\n";
  };
}

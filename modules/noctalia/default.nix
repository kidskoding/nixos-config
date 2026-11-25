{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.noctalia = {
    config,
    lib,
    pkgs,
    ...
  }: {
    imports = [inputs.noctalia-greeter.nixosModules.default];

    home-manager.sharedModules = [self.homeModules.noctalia];

    # greeter runs as the greeter user before login and cannot read ~/,
    # so its toml and assets go through the store and /etc (needs a rebuild)
    services.displayManager.noctalia-greeter = {
      enable = true;
      settings = lib.recursiveUpdate (lib.importTOML ./greeter/greeter.toml) {
        user.default = "kidskoding";
        appearance.font_family = config.stylix.fonts.sansSerif.name;
        output = {
          width = 1920;
          height = 1200;
          scale = 1.2;
        };
      };
    };

    environment.etc."noctalia-greeter/wallpaper.jpg".source = ./wallpapers/nixos-macchiato.jpg;

    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.adwaita-icon-theme
    ];

    systemd.tmpfiles.settings."10-accountsservice-avatar"."/var/lib/AccountsService/users/kidskoding"."f+".argument = "[User]\nIcon=${./avatars/starfire.jpeg}\n";
  };

  flake.homeModules.noctalia = {config, ...}: let
    dir = "/home/kidskoding/nixos/modules/noctalia";
    link = config.lib.file.mkOutOfStoreSymlink;
  in {
    xdg.configFile = {
      "noctalia/config.toml".source = link "${dir}/config.toml";
      "noctalia/conf.d".source = link "${dir}/conf.d";
      "noctalia/display.toml".source = link "${dir}/display.toml";
    };
  };
}

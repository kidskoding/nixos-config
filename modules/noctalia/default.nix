{
  inputs,
  self,
  ...
}: let
  wallpaper = pkgs: display: "${inputs.nix-wallpaper.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
    preset = "catppuccin-latte-rainbow";
    logoSize = 35;
    inherit (display) width height;
  }}/share/wallpapers/nixos-wallpaper.png";
in {
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
        output = {inherit (config.my.display) width height scale;};
      };
    };

    environment.etc."noctalia-greeter/wallpaper.jpg".source = wallpaper pkgs config.my.display;

    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.adwaita-icon-theme
    ];

    systemd.tmpfiles.settings."10-accountsservice-avatar"."/var/lib/AccountsService/users/kidskoding"."f+".argument = "[User]\nIcon=${./avatars/starfire.jpeg}\n";
  };

  flake.homeModules.noctalia = {
    config,
    pkgs,
    ...
  }: let
    dir = "/home/kidskoding/nixos/modules/noctalia";
    link = config.lib.file.mkOutOfStoreSymlink;
    d = config.my.display;
    narrow = d.width / d.scale < 1920;
  in {
    xdg.configFile = {
      "noctalia/config.toml".source = link "${dir}/config.toml";
      "noctalia/conf.d".source = link "${dir}/conf.d";

      "noctalia/display.toml".source = (pkgs.formats.toml {}).generate "noctalia-display.toml" {
        accessibility.ui_scale = 1.2 / d.scale;
        wallpaper.default.path = wallpaper pkgs d;
        shell.font_family = config.stylix.fonts.sansSerif.name;
        bar.main = {
          scale =
            if narrow
            then 1.0
            else 1.1;
          font_scale =
            if narrow
            then 1.0
            else 1.1;
          start =
            if narrow
            then ["control-center" "workspaces" "media"]
            else ["control-center" "workspaces"];
          center =
            if narrow
            then []
            else ["media"];
        };
        widget = {
          session.capsule_padding =
            if narrow
            then 10
            else 8;
          control-center.capsule_padding =
            if narrow
            then 10
            else 8;
        };
      };
    };
  };
}

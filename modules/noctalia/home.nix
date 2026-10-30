{...}: {
  flake.homeModules.niri = {
    config,
    lib,
    pkgs,
    ...
  }: let
    dir = "${config.my.flakeDir}/modules/noctalia";
    link = config.lib.file.mkOutOfStoreSymlink;
    d = config.my.display;
    narrow = d.width / d.scale < 1920;
  in {
    xdg.configFile = {
      "noctalia/config.toml".source = link "${dir}/config.toml";
      "noctalia/conf.d".source = link "${dir}/conf.d";

      "noctalia/display.toml".source = (pkgs.formats.toml {}).generate "noctalia-display.toml" {
        accessibility.ui_scale = 1.2 / d.scale;
        shell.font_family = config.stylix.fonts.sansSerif.name;
        bar.main =
          {
            scale =
              if narrow
              then 1.0
              else 1.1;
          }
          // lib.optionalAttrs narrow {
            font_scale = 1.0;
            start = ["control-center" "workspaces" "media"];
            center = [];
          };
      };
    };
  };
}

{ config, pkgs, ... }:

let
  images = ./images;
  current = "${images}/starfire-bg.jpg";
in
{
  home.packages = [ pkgs.awww ];

  programs.niri.settings.spawn-at-startup = [
    { argv = [ "awww-daemon" ]; }
    { sh = "sleep 2 && awww img --transition-type none ${current}"; }
  ];

  programs.noctalia-shell.settings.wallpaper = {
    enabled = true;
    directory = "${images}";
    fillMode = "crop";
  };

  xdg.cacheFile."noctalia/wallpapers.json".text = builtins.toJSON {
    wallpapers = builtins.mapAttrs (_: _: { dark = current; light = current; })
      config.programs.niri.settings.outputs;
  };
}

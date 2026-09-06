{ pkgs, ... }:

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
}

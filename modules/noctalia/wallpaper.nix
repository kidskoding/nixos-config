{...}: {
  flake.homeModules.noctalia = {...}: {
    programs.noctalia.settings = {
      wallpaper = {
        enabled = true;
        directory = "${./wallpapers}";
        fill_mode = "crop";
        default = {
          path = "${./wallpapers/starfire-bg.jpg}";
        };
      };
    };
  };
}

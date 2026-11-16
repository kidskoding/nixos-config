{...}: {
  flake.homeModules.desktop = {pkgs, ...}: {
    programs.mpv = {
      enable = true;

      scripts = with pkgs.mpvScripts; [
        mpris
        thumbfast
        uosc
      ];

      config = {
        hwdec = "auto-safe";
        keep-open = "yes";
        save-position-on-quit = "yes";
        osc = "no";
        osd-bar = "no";
        border = "no";
      };
    };
  };
}

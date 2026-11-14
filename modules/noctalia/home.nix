{inputs, ...}: {
  flake.homeModules.noctalia = {config, ...}: {
    imports = [inputs.noctalia.homeModules.default];

    my.caches = [
      # my own noctalia cache from my own fork: builds of the kidskoding/noctalia fork and the greeter
      {
        url = "https://kidskoding-noctalia.cachix.org";
        key = "kidskoding-noctalia.cachix.org-1:xVUU3CAdedgGC/sPwztDRg6d4KR3rRY22WufpMxFnu4=";
      }
    ];

    stylix.targets.noctalia.enable = false;

    programs.noctalia = {
      enable = true;
      settings = {
        theme = config.my.theme.noctalia;
        accessibility.ui_scale = 1.2 / config.my.display.scale;
        shell.font_family = config.stylix.fonts.sansSerif.name;
      };
    };
  };
}

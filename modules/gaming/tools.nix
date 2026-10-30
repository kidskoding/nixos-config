{...}: {
  flake.homeModules.gaming = {pkgs, ...}: {
    home.packages = with pkgs; [
      prismlauncher
      wineWow64Packages.stable
      winetricks

      # gaming deps
      bottles
      dolphin-emu
      heroic
      lutris
    ];
  };
}

{...}: {
  # config only: a nix-built mangohud layer does not load inside apt steam on victus
  flake.homeModules.gaming = {lib, ...}: let
    settings = {
      gpu_name = true;
      gpu_stats = true;
      gpu_temp = true;
      vram = true;

      cpu_stats = true;
      cpu_temp = true;
      ram = true;

      fps = true;
      frametime = true;
      resolution = true;

      position = "top-left";
      toggle_hud = "F10";
    };

    renderLine = k: v:
      if v == true
      then k
      else "${k}=${toString v}";
  in {
    xdg.configFile."MangoHud/MangoHud.conf".text =
      lib.concatStringsSep "\n" (lib.mapAttrsToList renderLine settings) + "\n";
  };
}

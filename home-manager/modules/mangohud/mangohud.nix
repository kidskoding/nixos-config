{ ... }:

{
  programs.mangohud = {
    enable = true;

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
  };
}

{...}: {
  flake.homeModules.desktop = {
    config,
    lib,
    pkgs,
    ...
  }: {
    programs.obs-studio = {
      enable = true;

      package = pkgs.obs-studio.override {
        cudaSupport = lib.elem "nvidia" config.my.gpu;
      };

      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
        obs-vkcapture
      ];
    };
  };
}

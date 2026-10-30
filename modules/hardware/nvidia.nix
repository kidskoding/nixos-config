{...}: {
  flake.nixosModules.base = {
    config,
    lib,
    ...
  }:
    lib.mkIf (lib.elem "nvidia" config.my.gpu) {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      services.xserver.videoDrivers = ["nvidia"];

      hardware.nvidia = {
        modesetting.enable = true;
        open = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        powerManagement = {
          enable = true;

          # power off the dGPU when no offloaded app is running
          # disabled: dGPU runtime-resume racing with dpms off hard-hangs the machine
          finegrained = false;
        };

        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
        };
      };
    };
}

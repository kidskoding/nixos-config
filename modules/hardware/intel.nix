{...}: {
  flake.nixosModules.base = {
    config,
    lib,
    ...
  }:
    lib.mkIf (lib.elem "intel" config.my.gpu) {
      boot.initrd.kernelModules = ["i915"];
      boot.kernelParams = ["i915.enable_psr=0"];
    };
}

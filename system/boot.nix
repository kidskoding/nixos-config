{ pkgs, ... }:

{
  boot = {
    loader = {
      grub.enable = true;
      grub.device = "nodev";
      grub.efiSupport = true;
      grub.gfxmodeEfi = "1920x1080";

      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;
      theme = "bgrt";
      themePackages = with pkgs; [
        nixos-bgrt-plymouth
      ];
    };

    consoleLogLevel = 0;
    initrd.verbose = false;
    initrd.systemd.enable = true;
    initrd.kernelModules = [ "i915" ];

    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };
}

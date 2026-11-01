{pkgs, ...}: {
  boot = {
    loader = {
      grub.enable = true;
      grub.device = "nodev";
      grub.efiSupport = true;

      efi.canTouchEfiVariables = true;

      timeout = 1;
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
    initrd.systemd.enable = false;
    initrd.systemd.emergencyAccess = true;

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

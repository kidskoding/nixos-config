{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix

    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
  ];

  networking.hostName = "nixos";
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users = {
    kidskoding = {
      isNormalUser = true;
      description = "Anirudh Konidala";

      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "libvirtd"
      ];
    };
  };

  boot = {
    loader = {
      grub.enable = true;
      grub.device = "nodev";
      grub.efiSupport = true;
      grub.gfxmodeEfi = "1920x1200";

      efi.canTouchEfiVariables = true;
      timeout = 5;
    };

    plymouth = {
      enable = true;
      theme = "bgrt";
      themePackages = with pkgs; [
        nixos-bgrt-plymouth
      ];
    };

    consoleLogLevel = 0;
    supportedFilesystems = ["btrfs" "fuse"];

    initrd.systemd.emergencyAccess = true;

    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "amdgpu.dcdebugmask=0x10"
      "amdgpu.sg_display=0"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {inherit inputs;};

    users.kidskoding.imports = [
      inputs.self.homeModules.base
    ];
  };

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/kidskoding/.config/sops/age/keys.txt";
  };

  security = {
    rtkit.enable = true;
    sudo.extraConfig = "Defaults pwfeedback";
    polkit.extraConfig = builtins.readFile ./extras/gparted.rules;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.amdgpu.initrd.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.upower.enable = true;
  services.upower.criticalPowerAction = "Hibernate";
  services.power-profiles-daemon.enable = true;

  systemd.tmpfiles.rules = [
    "w /sys/class/power_supply/BAT0/charge_control_end_threshold - - - - 100"
    "w /sys/class/power_supply/BAT0/charge_control_start_threshold - - - - 0"
  ];

  zramSwap.enable = true;
  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024;
    }
  ];

  services.logind.settings.Login = {
    HandleLidSwitch = "lock";
    HandlePowerKey = "poweroff";
  };

  virtualisation.vmVariant = {
    users.users.kidskoding.initialPassword = "test";

    services.greetd.settings.initial_session = {
      user = "kidskoding";
      command = "niri-session";
    };
    services.xserver.videoDrivers = lib.mkForce ["modesetting"];

    virtualisation = {
      memorySize = 8192;
      cores = 4;
      sharedDirectories.nixos = {
        source = "/home/kidskoding/nixos";
        target = "/home/kidskoding/nixos";
        writable = false;
      };
      qemu.options = [
        "-vga none"
        "-device virtio-vga-gl"
        "-display gtk,gl=on"
      ];
    };
  };

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  virtualisation.libvirtd.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    efibootmgr
    gdb
    git
    gparted
    perf
    pkg-config
    psmisc
    python315
    sops
    unzip
    vim
    wget
    woeusb-ng

    # apt build-essential
    stdenv.cc
    gnumake
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # run prebuilt binaries (uv-managed pythons, pip wheels, etc.) when necessary
  programs.nix-ld.enable = true;

  programs.fuse.userAllowOther = true;
  programs.virt-manager.enable = true;

  programs.steam.enable = true;
  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  # nautilus: trash, mounts, and settings storage
  services.gvfs.enable = true;
  programs.dconf.enable = true;

  environment.sessionVariables = {
    # run electron/chromium apps (discord, spotify) natively on wayland
    # instead of xwayland
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";

    # fixes java app scaling/rendering on wayland!
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  systemd.globalEnvironment = {
    SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.11"; # Did you read the comment?
}

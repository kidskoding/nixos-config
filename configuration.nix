{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
  ];

  boot = {
    loader = {
      grub.enable = true;
      grub.device = "nodev";
      grub.efiSupport = true;

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

    initrd.verbose = false;
    initrd.systemd.enable = true;
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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {inherit inputs;};
  };

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/kidskoding/.config/sops/age/keys.txt";
  };

  security = {
    rtkit.enable = true;
    sudo.extraConfig = ''
      Defaults pwfeedback
    '';
    polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (action.id == "org.gnome.gparted" &&
            subject.isInGroup("wheel") && subject.local && subject.active) {
          return polkit.Result.YES;
        }
      });
    '';
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.upower.enable = true;
  services.upower.criticalPowerAction = "Hibernate";
  services.power-profiles-daemon.enable = true;

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

  # the home every host gets; hosts add their own groups in modules/hosts/
  home-manager.users.kidskoding.imports = [inputs.self.homeModules.base];

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
        source = config.my.flakeDir;
        target = config.my.flakeDir;
        writable = false;
      };
      qemu.options = [
        "-vga none"
        "-device virtio-vga-gl"
        "-display gtk,gl=on"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    efibootmgr
    gdb
    git
    gparted
    pkg-config
    psmisc
    python315
    sops
    unzip
    vim
    wget

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

  systemd.globalEnvironment = {
    SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
  };

  programs.fuse.userAllowOther = true;

  # nautilus: trash, mounts, and settings storage
  services.gvfs.enable = true;
  programs.dconf.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  environment.sessionVariables = {
    # run electron/chromium apps (discord, spotify) natively on wayland
    # instead of xwayland
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";

    # fixes java app scaling/rendering on wayland!
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}

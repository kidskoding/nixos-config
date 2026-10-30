{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./boot.nix
    ./networking.nix

    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {inherit inputs;};
    users.kidskoding = {
      sops = {
        defaultSopsFile = ./secrets/secrets.yaml;
        age.keyFile = "/home/kidskoding/.config/sops/age/keys.txt";
      };
    };
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

  services.logind.settings.Login.HandleLidSwitch = "suspend";

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  users.users = {
    kidskoding = {
      isNormalUser = true;
      description = "Anirudh Konidala";

      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
    };
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

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    efibootmgr
    gcc
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

  boot.supportedFilesystems = ["btrfs" "fuse"];
  programs.fuse.userAllowOther = true;

  # nautilus: trash, mounts, and settings storage
  services.gvfs.enable = true;
  programs.dconf.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  # run electron/chromium apps (discord, spotify) natively on wayland
  # instead of xwayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}

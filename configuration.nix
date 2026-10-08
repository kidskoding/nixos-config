{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./networking.nix
    ./nvidia.nix
    ./disko.nix
    ./packages.nix
    ./stylix.nix
    ./home-manager/programs/noctalia/greeter.nix

    inputs.disko.nixosModules.disko
    inputs.evergarden.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    inputs.niri.nixosModules.niri
    inputs.noctalia-greeter.nixosModules.default
    inputs.sops-nix.nixosModules.sops
    inputs.stylix.nixosModules.stylix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {inherit inputs;};
    users.anirudh = import ./home-manager/home.nix;
  };

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/anirudh/.config/sops/age/keys.txt";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # do not warn if git tree is dirty when rebuilding system
  nix.settings.warn-dirty = false;

  # prebuilt nix-community builds
  # instead of compiling from source
  nix.settings.substituters = [
    "https://nix-community.cachix.org"
    "https://devenv.cachix.org"
    "https://noctalia.cachix.org"
    "https://pkulak.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    # bun2nix trusted public key
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="

    # devenv trusted public key
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="

    # noctalia trusted public key
    "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="

    # matui trusted public key
    "pkulak.cachix.org-1:S25jAptWCkAmwrk41b47lheB9onW9mzxVqM9o6HRg1E="
  ];

  security.rtkit.enable = true;
  security.sudo.extraConfig = ''
    Defaults pwfeedback
  '';

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.upower.enable = true;
  services.upower.criticalPowerAction = "Hibernate";

  zramSwap.enable = true;
  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024;
    }
  ];
  services.logind.settings.Login.HandleLidSwitch = "lock";

  programs.steam.enable = true;
  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

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
    "anirudh" = {
      isNormalUser = true;
      description = "Anirudh Konidala";

      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];

      shell = pkgs.fish;
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    efibootmgr
    gcc
    gdb
    git
    pkg-config
    psmisc
    python313
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

  programs.fish.enable = true;

  # run prebuilt binaries (uv-managed pythons, pip wheels, etc.) when necessary
  programs.nix-ld.enable = true;

  # niri!!!
  nixpkgs.overlays = [
    (final: prev: {
      libdisplay-info_0_2 = prev.libdisplay-info.overrideAttrs (old: rec {
        version = "0.2.0";
        src = prev.fetchFromGitLab {
          domain = "gitlab.freedesktop.org";
          owner = "emersion";
          repo = "libdisplay-info";
          rev = version;
          hash = "sha256-6xmWBrPHghjok43eIDGeshpUEQTuwWLXNHg7CnBUt3Q=";
        };
      });
    })

    inputs.niri.overlays.niri
  ];
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
  niri-flake.cache.enable = false;

  systemd.packages = [config.programs.niri.package];
  systemd.globalEnvironment = {
    SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
  };

  boot.supportedFilesystems = ["btrfs" "fuse"];
  programs.fuse.userAllowOther = true;

  # plasma (dolphin-style) file dialog for portal-using apps
  xdg.portal.extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  # run electron/chromium apps (discord, spotify) natively on wayland
  # instead of xwayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  system.autoUpgrade = {
    enable = true;
    flake = "github:kidskoding/nixos-config";
    flags = ["-L"];
    dates = "hourly";
    randomizedDelaySec = "10min";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  systemd.services.nixos-upgrade.preStart = ''
    ${pkgs.util-linux}/bin/runuser -u anirudh -- ${pkgs.bash}/bin/bash -c '
      export HOME=/home/anirudh
      cd /home/anirudh/nixos || exit 0
      git pull --ff-only || exit 0
      nix flake update anikonistack --commit-lock-file || exit 0
      git push || true
    '
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}

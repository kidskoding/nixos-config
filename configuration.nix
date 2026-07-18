# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # bootloader
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
    };

    consoleLogLevel = 0;
    initrd.verbose = false;
    initrd.systemd.enable = true;

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

  networking.hostName = "nixos";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;
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
    	extraGroups = [ "networkmanager" "wheel" ];

	shell = pkgs.fish;
     }; 
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
     vim
     wget
     git
     firefox
     psmisc
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.fish.enable = true;
  
  # run prebuilt binaries (uv-managed pythons, pip wheels, etc.)
  programs.nix-ld.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  services.displayManager = {
    sddm = {
    	enable = true;
   	wayland.enable = true;
    };

    defaultSession = "hyprland";
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}

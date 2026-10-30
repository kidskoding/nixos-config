{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.thinkpad = {...}: {
    imports = [
      ../../hosts/thinkpad/hardware-configuration.nix
      ../../hosts/thinkpad/disko.nix
    ];

    my = {
      gpu = ["amd"];
      display = {
        width = 1920;
        height = 1200;
        scale = 1.2;
      };
    };

    stylix.fonts.sizes.terminal = 14;

    systemd.tmpfiles.rules = [
      "w /sys/class/power_supply/BAT0/charge_control_end_threshold - - - - 100"
      "w /sys/class/power_supply/BAT0/charge_control_start_threshold - - - - 0"
    ];

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "26.05"; # Did you read the comment?

    home-manager.users.kidskoding.home.stateVersion = "26.05";
  };

  flake.nixosConfigurations.thinkpad = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
    };
    modules = with self.nixosModules; [
      base
      kidskoding
      shell
      stylix

      niri
      noctalia
      desktop

      dev
      agents

      thinkpad
    ];
  };
}

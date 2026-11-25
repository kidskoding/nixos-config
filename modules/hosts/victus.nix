{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.victus = {lib, ...}: {
    imports = [
      ../../hosts/victus/hardware-configuration.nix
      ../../hosts/victus/disko.nix
    ];

    networking.hostName = "victus16";

    my = {
      gpu = ["intel" "nvidia"];
      display = {
        width = 1920;
        height = 1080;
        refresh = 144.0;
        vrr = true;
      };
    };

    # thinkpad sizes x1.2: thinkpad gets that from its 1.2 output scale, victus stays at 1.0
    stylix.fonts.sizes = lib.mkForce {
      terminal = 17;
      applications = 14;
      desktop = 13;
      popups = 13;
    };

    boot.kernelParams = ["pci=noaer"];

    hardware.nvidia.prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };

    home-manager.users.kidskoding = {
      home.stateVersion = "26.11";

      programs.fish.shellAliases.rebuild = lib.mkForce "env HOST=victus16 /home/kidskoding/nixos/scripts/rebuild.sh";
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "26.11"; # Did you read the comment?
  };

  flake.nixosConfigurations."victus16" = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
    };
    modules = with self.nixosModules; [
      base
      shell
      theme

      niri
      noctalia
      desktop

      dev
      agents
      gaming

      victus
    ];
  };
}

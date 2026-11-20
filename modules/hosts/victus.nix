{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.victus = {
    config,
    lib,
    ...
  }: {
    imports = [
      ../../hosts/victus/hardware-configuration.nix
      ../../hosts/victus/disko.nix
    ];

    my = {
      gpu = ["intel" "nvidia"];
      display = {
        width = 1920;
        height = 1080;
        refresh = 144.0;
        vrr = true;
        textScale = 1.25;
      };
    };

    boot.kernelParams = ["pci=noaer"];

    hardware.nvidia.prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };

    home-manager.users.kidskoding = {
      home.stateVersion = "26.11";

      programs.fish.shellAliases.rebuild = lib.mkForce "env HOST=victus ${config.my.flakeDir}/scripts/rebuild.sh";
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "26.11"; # Did you read the comment?
  };

  flake.nixosConfigurations.victus = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
    };
    modules = with self.nixosModules; [
      base
      kidskoding
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

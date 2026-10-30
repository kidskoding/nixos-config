{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.victus = {lib, ...}: {
    imports = [
      ../../hosts/victus/hardware-configuration.nix
      ../../hosts/victus/disko.nix
      self.nixosModules.gaming
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

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "26.11"; # Did you read the comment?

    home-manager.users.kidskoding = {
      imports = [self.homeModules.gaming];
      home.stateVersion = "26.11";

      # both hosts are named nixos, so rebuild.sh needs the flake host spelled out
      programs.fish.shellAliases.rebuild = lib.mkForce "env HOST=victus /home/kidskoding/nixos/scripts/rebuild.sh";
    };
  };

  flake.nixosConfigurations.victus = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
    };
    modules = [
      self.nixosModules.base
      self.nixosModules.kidskoding
      self.nixosModules.shell
      self.nixosModules.niri
      self.nixosModules.noctalia
      self.nixosModules.stylix
      self.nixosModules.victus
    ];
  };
}

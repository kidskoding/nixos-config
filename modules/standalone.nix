# standalone home-manager configuration without nixos (i.e. my victus on pop!! os)
{
  inputs,
  lib,
  self,
  ...
}: {
  flake.lib.mkHome = {
    modules ? [],
    system ? "x86_64-linux",
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      extraSpecialArgs = {inherit inputs;};
      modules =
        [
          self.homeModules.kidskoding
          self.homeModules.standalone
          {
            home = {
              username = "kidskoding";
              homeDirectory = "/home/kidskoding";
              stateVersion = lib.mkDefault "26.05";
            };
          }
        ]
        ++ modules;
    };

  flake.homeModules.standalone = {
    config,
    lib,
    pkgs,
    ...
  }: let
    link = config.lib.file.mkOutOfStoreSymlink;
  in {
    imports = [
      self.homeModules.stylix
      inputs.sops-nix.homeModules.sops
    ];

    # gpu driver shims for nix-built apps need `sudo non-nixos-gpu-setup` once
    targets.genericLinux.enable = true;

    programs.home-manager.enable = true;

    xdg.configFile."home-manager".source = link config.my.flakeDir;

    nix.package = pkgs.nix;

    sops = {
      defaultSopsFile = ../secrets/secrets.yaml;
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    };

    # sudo has no nix on PATH here; home-manager generations are user profiles
    programs.fish.shellAliases = {
      hm-rebuild = "${config.my.flakeDir}/scripts/hm-rebuild.sh";
      collect-garbage = lib.mkForce "nix-collect-garbage --delete-older-than 7d";
    };
  };
}

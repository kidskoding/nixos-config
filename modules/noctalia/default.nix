{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.noctalia = {pkgs, ...}: {
    home-manager.sharedModules = [self.homeModules.noctalia];

    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.adwaita-icon-theme
    ];
  };
}

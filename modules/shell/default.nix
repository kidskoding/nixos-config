{...}: {
  flake.nixosModules.shell = {pkgs, ...}: {
    programs.fish.enable = true;
    users.users.kidskoding.shell = pkgs.fish;
  };
}

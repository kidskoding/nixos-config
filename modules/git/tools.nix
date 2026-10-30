{...}: {
  flake.homeModules.kidskoding = {pkgs, ...}: {
    home.packages = [pkgs.github-cli];
  };
}

{...}: {
  flake.homeModules.base = {pkgs, ...}: {
    home.packages = [pkgs.github-cli];
  };
}

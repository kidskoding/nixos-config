{ config, pkgs, ... }:

{
  imports = [
    ./modules
    ./git.nix
    ./fish.nix
  ];

  home.username = "anirudh";
  home.homeDirectory = "/home/anirudh";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
      # applications
      firefox
      spotify
      discord
 
      wl-clipboard
      cliphist
      tree
      ripgrep

      uv
      github-cli
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.home-manager.enable = true;
}

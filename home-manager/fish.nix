{ config, pkgs, ... }:

{
  programs.fish = {
     enable = true;
     shellAliases = {
        lsa = "ls -al"; 
        rebuild = "sudo nixos-rebuild switch --flake /home/anirudh/nixos#nixos";
     };
  };
}

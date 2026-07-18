{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Anirudh Konidala";
    userEmail = "anirudhkonidala@gmail.com";

    extraConfig = {
      core.editor = "vim";
      init.defaultBranch = "master";
      advice.defaultBranchName = false;
    };
  };
}

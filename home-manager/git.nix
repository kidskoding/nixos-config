{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name = "Anirudh Konidala";
      user.email = "anirudhkonidala@gmail.com";
      core.editor = "vim";
      init.defaultBranch = "master";
      advice.defaultBranchName = false;
    };
  };
}

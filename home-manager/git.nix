{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name = "Anirudh Konidala";
      user.email = "anirudhkonidala@gmail.com";
      core.editor = ''emacsclient -nw -a ""'';
      init.defaultBranch = "master";
      advice.defaultBranchName = false;
    };
  };
}

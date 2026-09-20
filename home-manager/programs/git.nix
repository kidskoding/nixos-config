{ config, ... }:

let
  colors = config.theme.colors;
  status = config.programs.git.settings.color.fileStatus;
in
{
  programs.git = {
    enable = true;

    settings = {
      user.name = "Anirudh Konidala";
      user.email = "anirudhkonidala@gmail.com";
      init.defaultBranch = "master";
      advice.defaultBranchName = false;

      color.fileStatus = {
        added = colors.greenBright;
        removed = colors.redBright;
        modified = colors.yellowBright;
        untracked = colors.aquaBright;
        renamed = colors.purpleBright;
        ignored = colors.grayBright;
      };
      color.diff = {
        new = status.added;
        old = status.removed;
      };
      color.status.untracked = status.untracked;
    };

    ignores = [
      "result"
    ];
  };
}

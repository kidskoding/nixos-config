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

      alias = {
        dft = "!GIT_EXTERNAL_DIFF=difft git diff";
        dlog = "!GIT_EXTERNAL_DIFF=difft git log --ext-diff -p";
        dshow = "!GIT_EXTERNAL_DIFF=difft git show --ext-diff";
      };

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
      core.editor = "nvim";
    };

    ignores = [
      "result"
    ];
  };
}

{config, ...}: let
  colors = config.lib.stylix.colors.withHashtag;
  status = config.programs.git.settings.color.fileStatus;
in {
  programs.difftastic = {
    enable = true;
    git.enable = true;
  };

  programs.git = {
    enable = true;

    settings = {
      user.name = "Anirudh Konidala";
      user.email = "anirudhkonidala@gmail.com";
      init.defaultBranch = "master";
      advice.defaultBranchName = false;

      alias = {
        dlog = "!GIT_EXTERNAL_DIFF=difft git log --ext-diff -p";
        dshow = "!GIT_EXTERNAL_DIFF=difft git show --ext-diff";
      };

      color.fileStatus = {
        added = colors.base0B;
        removed = colors.base08;
        modified = colors.base0A;
        untracked = colors.base0C;
        renamed = colors.base0E;
        ignored = colors.base04;
      };

      color.diff = {
        new = status.added;
        old = status.removed;
      };

      color.status = {
        added = status.added;
        changed = status.modified;
        untracked = status.untracked;
      };

      core.editor = "nvim";
    };

    ignores = [
      "result" # symlink when building to /nix/store
      "result-*"

      # direnv and devenv
      ".direnv"
      ".devenv"
    ];
  };
}

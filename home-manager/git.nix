{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name = "Anirudh Konidala";
      user.email = "anirudhkonidala@gmail.com";
      init.defaultBranch = "master";
      advice.defaultBranchName = false;
    };

    ignores = [
      ".envrc"
      ".direnv/"
    ];
  };
}

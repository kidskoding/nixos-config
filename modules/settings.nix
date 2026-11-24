{
  flake.nixosModules.base = {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # do not warn if git tree is dirty when rebuilding system
      warn-dirty = false;

      substituters = [
        "https://nix-community.cachix.org"
        "https://pkulak.cachix.org"
        "https://devenv.cachix.org"
        "https://cache.numtide.com"
        "https://applicative-systems.cachix.org"
        "https://kidskoding-noctalia.cachix.org"
      ];

      trusted-public-keys = [
        # nix-community
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="

        # matui
        "pkulak.cachix.org-1:S25jAptWCkAmwrk41b47lheB9onW9mzxVqM9o6HRg1E="

        # devenv
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="

        # llm-agents (numtide)
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="

        # artcraft
        "applicative-systems.cachix.org-1:ND41hRBh0ST2abuI/oee3yWVf3n0FsAftyJJ/Tb7KDE="

        # my noctalia fork
        "kidskoding-noctalia.cachix.org-1:xVUU3CAdedgGC/sPwztDRg6d4KR3rRY22WufpMxFnu4="
      ];
    };
  };
}

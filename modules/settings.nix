{...}: let
  # prebuilt nix-community builds
  # instead of compiling from source
  caches = [
    "https://nix-community.cachix.org"
    "https://devenv.cachix.org"
    "https://noctalia.cachix.org"
    "https://pkulak.cachix.org"
    "https://cache.numtide.com"
    "https://applicative-systems.cachix.org"
  ];

  keys = [
    # bun2nix trusted public key
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="

    # devenv trusted public key
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="

    # noctalia trusted public key
    "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="

    # matui trusted public key
    "pkulak.cachix.org-1:S25jAptWCkAmwrk41b47lheB9onW9mzxVqM9o6HRg1E="

    # llm-agents trusted public key
    "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="

    # artcraft trusted public key
    "applicative-systems.cachix.org-1:ND41hRBh0ST2abuI/oee3yWVf3n0FsAftyJJ/Tb7KDE="
  ];

  common = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # do not warn if git tree is dirty when rebuilding system
    warn-dirty = false;
  };
in {
  flake.nixosModules.base.nix.settings =
    common
    // {
      substituters = caches;
      trusted-public-keys = keys;
    };

  # extra-* keeps cache.nixos.org; the daemon only honours these for a
  # trusted user, so pop!_os needs `trusted-users = root kidskoding` in /etc/nix/nix.conf
  flake.homeModules.standalone.nix.settings =
    common
    // {
      extra-substituters = caches;
      extra-trusted-public-keys = keys;
    };
}

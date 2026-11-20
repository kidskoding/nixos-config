# each group lists its binary caches in `my.caches`, next to the packages that need them
{lib, ...}: {
  flake.homeModules.base = {
    options.my.caches = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          url = lib.mkOption {type = lib.types.str;};
          key = lib.mkOption {type = lib.types.str;};
        };
      });
      default = [];
    };

    config.my.caches = [
      # nix-community cache
      {
        url = "https://nix-community.cachix.org";
        key = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
      }
    ];
  };

  flake.nixosModules.base = {config, ...}: let
    caches = lib.unique (lib.concatMap (user: user.my.caches) (lib.attrValues config.home-manager.users));
  in {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # do not warn if git tree is dirty when rebuilding system
      warn-dirty = false;

      substituters = map (cache: cache.url) caches;
      trusted-public-keys = map (cache: cache.key) caches;
    };
  };
}

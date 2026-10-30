# each group lists its binary caches in `my.caches`, next to the packages that need them
{lib, ...}: let
  common = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # do not warn if git tree is dirty when rebuilding system
    warn-dirty = false;
  };

  urls = map (c: c.url);
  keys = map (c: c.key);
in {
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
    nix.settings =
      common
      // {
        substituters = urls caches;
        trusted-public-keys = keys caches;
      };
  };

  # extra-* keeps cache.nixos.org; the daemon only honours these for a
  # trusted user, so non-nixos machines need `trusted-users = root <user>` in /etc/nix/nix.conf
  flake.homeModules.standalone = {config, ...}: let
    caches = lib.unique config.my.caches;
  in {
    nix.settings =
      common
      // {
        extra-substituters = urls caches;
        extra-trusted-public-keys = keys caches;
      };
  };
}

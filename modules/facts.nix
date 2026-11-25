# per-machine facts (i.e. gpu, display) so that each host can set them.
# modules like niri, noctalia, and grub can read "config.my" instead of hardcoding!
{lib, ...}: let
  inherit (lib) mkOption types;

  options.my = {
    gpu = mkOption {
      type = types.listOf (types.enum ["amd"]);
      default = [];
    };

    display = {
      output = mkOption {
        type = types.str;
        default = "eDP-1";
      };

      width = mkOption {type = types.int;};
      height = mkOption {type = types.int;};

      scale = mkOption {
        type = types.float;
        default = 1.0;
      };
    };
  };
in {
  flake.nixosModules.base = {config, ...}: {
    inherit options;
    config.home-manager.sharedModules = [{inherit (config) my;}];
  };

  flake.homeModules.base = {inherit options;};
}

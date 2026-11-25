{...}: {
  flake.nixosModules.base = {config, ...}: let
    d = config.my.display;
  in {
    boot.loader.grub.gfxmodeEfi = "${toString d.width}x${toString d.height}";
  };

  flake.homeModules.niri = {config, ...}: let
    d = config.my.display;
  in {
    programs.niri.settings.outputs.${d.output} = {
      position = {
        x = 0;
        y = 0;
      };
      inherit (d) scale;
    };
  };

  flake.homeModules.base = {
    config,
    lib,
    ...
  }: let
    d = config.my.display;
  in {
    programs.ghostty.settings.adjust-cursor-thickness =
      lib.mkIf (d.scale != builtins.floor d.scale) 1;
  };
}

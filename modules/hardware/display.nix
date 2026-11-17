{...}: {
  flake.nixosModules.base = {config, ...}: let
    d = config.my.display;
  in {
    boot.loader.grub.gfxmodeEfi = "${toString d.width}x${toString d.height}";
  };

  flake.homeModules.niri = {
    config,
    lib,
    ...
  }: let
    d = config.my.display;
  in {
    programs.niri.settings = {
      outputs.${d.output} = {
        mode = lib.mkIf (d.refresh != null) {inherit (d) width height refresh;};
        position = {
          x = 0;
          y = 0;
        };
        inherit (d) scale;
        variable-refresh-rate = lib.mkIf d.vrr "on-demand";
      };

      environment = lib.mkIf (d.textScale != 1.0) {
        GDK_DPI_SCALE = lib.strings.floatToString d.textScale;
        QT_FONT_DPI = toString (builtins.floor (96 * d.textScale));
      };
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

{...}: {
  flake.nixosModules.base = {config, ...}: let
    d = config.my.display;
  in {
    boot.loader.grub.gfxmodeEfi = "${toString d.width}x${toString d.height}";
  };

  flake.homeModules.umbriel = {
    config,
    lib,
    ...
  }: let
    d = config.my.display;
  in {
    programs.umbriel.settings = {
      output.${d.output} = {
        mode = lib.mkIf (d.refresh != null) "${toString d.width}x${toString d.height}@${toString (builtins.floor d.refresh)}";
        position = [0 0];
        inherit (d) scale;
      };

      environment = lib.mkIf (d.textScale != 1.0) {
        GDK_DPI_SCALE = lib.strings.floatToString d.textScale;
        QT_FONT_DPI = toString (builtins.floor (96 * d.textScale));
      };
    };
  };

  flake.homeModules.mango = {
    config,
    lib,
    ...
  }: let
    d = config.my.display;
  in {
    xdg.configFile."mango/config.conf".text = lib.concatLines (
      [
        "monitorrule=name:^${d.output}$,width:${toString d.width},height:${toString d.height},${lib.optionalString (d.refresh != null) "refresh:${toString d.refresh},"}x:0,y:0,scale:${toString d.scale}"
      ]
      ++ lib.optionals (d.textScale != 1.0) [
        "env=GDK_DPI_SCALE,${lib.strings.floatToString d.textScale}"
        "env=QT_FONT_DPI,${toString (builtins.floor (96 * d.textScale))}"
      ]
    );
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

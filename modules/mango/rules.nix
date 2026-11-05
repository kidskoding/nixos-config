{...}: {
  flake.homeModules.mango = {
    config,
    lib,
    ...
  }: {
    xdg.configFile."mango/config.conf".text = lib.concatLines (
      [
        "windowrule=scroller_proportion:1.0,appid:^discord$"
        # offset 100 is the screen edge (minus outer gap), so this pins toasts bottom-right
        "windowrule=isfloating:1,offsetx:100,offsety:100,appid:^steam$,title:^notificationtoasts_[0-9]+_desktop$"
        "windowrule=isfullscreen:1,appid:^(steam_app_.*|gamescope)$"
      ]
      # vrr_only_fullscreen needs the monitor rule's vrr left at 0
      ++ lib.optional config.my.display.vrr "windowrule=vrr_only_fullscreen:1,appid:^(steam_app_.*|gamescope)$"
    );
  };
}

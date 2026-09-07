{ ... }:

{
  # zen draws its own gtk file dialog unless the portal picker is forced on
  # (default 2 = "auto" only fires under flatpak/snap or GTK_USE_PORTAL=1).
  # profile dir is machine-local -- see ~/.config/zen/profiles.ini if it changes.
  home.file.".config/zen/xez3wz0f.Default Profile/user.js".text = ''
    user_pref("widget.use-xdg-desktop-portal.file-picker", 1);
  '';
}

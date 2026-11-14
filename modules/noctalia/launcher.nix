{...}: {
  flake.homeModules.noctalia = {
    lib,
    pkgs,
    ...
  }: let
    system = "/nix/var/nix/profiles/system";

    switchTheme = lib.getExe (pkgs.writeShellApplication {
      name = "switch-theme";
      text = builtins.readFile ./switch-theme.sh;
    });
  in {
    programs.noctalia.settings = {
      shell = {
        launcher = {
          categories = false;
          sort_by_usage = false;
          pinned = [
            "nixos-manual"
            "com.mitchellh.ghostty"
            "Celeste"
            "claude"
            "discord"
            "Enter the Gungeon"
            "Hollow Knight"
            "lunarclient"
            "orca-ide"
            "org.gnome.Nautilus"
            "org.neovim.nvim"
            "qimgv"
            "rs.ruffle.Ruffle"
            "spotify"
            "Stardew Valley"
            "steam"
            "The Binding of Isaac Rebirth"
            "zen-beta"
          ];

          dmenu.entry.theme = {
            label = "Themes";
            prefix = "theme";
            glyph = "palette";
            global = false;
            command = "cat ${system}/etc/theme; ls ${system}/specialisation";
            exec = "${switchTheme} '{selection}'";
          };
        };
      };
    };
  };
}

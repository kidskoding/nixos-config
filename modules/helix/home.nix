{...}: {
  flake.homeModules.kidskoding = {pkgs, ...}: {
    # backup editor for when nvim breaks: helix fork with vim keybindings, run as `hx`.
    programs.helix = {
      enable = true;
      package = pkgs.evil-helix;

      settings = {
        theme = "gruvbox_custom";

        editor = {
          line-number = "absolute";
          cursorline = true;
          color-modes = true;
        };
      };

      themes.gruvbox_custom = {
        inherits = "gruvbox";

        # NOR badge yellow (gruvbox default is grey fg3)
        "ui.statusline.normal" = {
          fg = "bg1";
          bg = "yellow0";
          modifiers = ["bold"];
        };
      };
    };
  };
}

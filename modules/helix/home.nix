{...}: {
  flake.homeModules.dev-core = {
    lib,
    pkgs,
    ...
  }: {
    # backup editor for when nvim breaks: helix fork with vim keybindings, run as `hx`.
    programs.helix = {
      enable = true;
      package = pkgs.evil-helix;

      settings = {
        theme = lib.mkForce "stylix_custom";

        editor = {
          line-number = "absolute";
          cursorline = true;
          color-modes = true;
        };
      };

      themes.stylix_custom = {
        inherits = "stylix";

        # NOR badge yellow (stylix default is grey base03)
        "ui.statusline.normal" = {
          fg = "base00";
          bg = "base0A";
          modifiers = ["bold"];
        };
      };
    };
  };
}

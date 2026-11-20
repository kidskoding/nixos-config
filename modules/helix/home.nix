{...}: {
  flake.homeModules.dev-core = {pkgs, ...}: {
    # backup editor for when nvim breaks: helix fork with vim keybindings, run as `hx`.
    programs.helix = {
      enable = true;
      package = pkgs.evil-helix;

      settings = {
        editor = {
          line-number = "absolute";
          cursorline = true;
          color-modes = true;

          soft-wrap = {
            enable = true;
            wrap-indicator = "";
          };
        };
      };
    };
  };
}

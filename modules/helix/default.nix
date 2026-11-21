{...}: {
  flake.homeModules.dev-core = {
    config,
    pkgs,
    ...
  }: {
    xdg.configFile."helix/languages.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.my.flakeDir}/modules/helix/languages.toml";

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

        keys.normal = {
          "C-p" = ":sh flow %<cr>";
        };
      };

      extraPackages = with pkgs; [glow];
    };
  };
}

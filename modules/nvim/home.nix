{...}: {
  flake.homeModules.kidskoding = {
    inputs,
    config,
    pkgs,
    ...
  }: let
    dir = "${config.my.flakeDir}/modules/nvim/config";
    link = config.lib.file.mkOutOfStoreSymlink;
    system = pkgs.stdenv.hostPlatform.system;
    neovim = inputs.neovim-nightly-overlay.packages.${system}.default;
  in {
    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    home.packages = [neovim];

    xdg.configFile."nvim".source = link dir;

    # nightly ships both nvim.desktop and org.neovim.nvim.desktop (identical); hide the legacy one
    xdg.dataFile."applications/nvim.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Neovim
      Hidden=true
    '';
  };
}

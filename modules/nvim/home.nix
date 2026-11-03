{inputs, ...}: {
  flake.homeModules.dev-core = {
    config,
    pkgs,
    ...
  }: let
    dir = "${config.my.flakeDir}/modules/nvim/config";
    link = config.lib.file.mkOutOfStoreSymlink;
    system = pkgs.stdenv.hostPlatform.system;
    nightly = inputs.neovim-nightly-overlay.packages.${system}.default;
    # borrow nixpkgs' lua: nightly's luajit clashes with the one vimPlugins are built against
    neovim = pkgs.wrapNeovimUnstable (nightly // {inherit (pkgs.neovim-unwrapped) lua;}) {
      plugins = import ./config/plugins.nix pkgs.vimPlugins;
      wrapRc = false;
    };
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

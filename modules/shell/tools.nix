{...}: {
  flake.homeModules.base = {pkgs, ...}: {
    programs.bat.enable = true;

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    home.packages = with pkgs; [
      # additional user system tools
      fd
      jq
      ripgrep
      tree
      tree-sitter
      websocat
    ];
  };
}

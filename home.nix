{ config, pkgs, ... }:

{
  imports = [
     ./modules/python.nix
  ];

  home.username = "anirudh";
  home.homeDirectory = "/home/anirudh";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
      htop
      fastfetch
      firefox
      fuzzel
      fastfetch
      alacritty
      fuzzel
      firefox
      wl-clipboard
      cliphist

      # Developer Tools
      github-cli
      neovim
      cmake
      xmake
      nodejs
      go
      rustup
      claude-code
  ];
  
  home.sessionPath = [
      "$HOME/.local/bin"
  ];

  programs.git = {
    enable = true;
    userName = "Anirudh Konidala";
    userEmail = "kidskodingclub@gmail.com";
    
    extraConfig = {
	core.editor = "nvim";
	init.defaultBranch = "master";
	safe.directory = "/home/anirudh/nixos";
    };
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

  programs.home-manager.enable = true;
}

{ config, pkgs, ... }:

{
  imports = [
     ./modules/python.nix
     ./modules/alacritty/alacritty.nix
     ./modules/niri.nix
  ];

  home.username = "anirudh";
  home.homeDirectory = "/home/anirudh";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
      htop
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
      uv
      go
      rustup
      starship
      nerd-fonts.jetbrains-mono
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

  programs.fish = {
    enable = true;
    shellInit = ''
       fish_add_path $HOME/.local/bin
    '';
  };

  programs.home-manager.enable = true;
}

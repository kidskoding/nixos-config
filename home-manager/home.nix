{ config, pkgs, ... }:

{
  imports = [
    ./modules
    ./git.nix
    ./fish.nix
  ];

  home.username = "anirudh";
  home.homeDirectory = "/home/anirudh";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
      # applications
      firefox
      spotify
      discord

      # additional system tools
      wl-clipboard
      cliphist
      tree
      ripgrep
      
      # languages
      go
      jdk21
      ruby
      dotnet-sdk_10
      lua
      zig

      # core developer tools
      uv
      nodejs
      bun
      cmake
      xmake
      bear  

      # niche c / c++ tooling 
      ninja
      valgrind
      clang-tools
      pkg-config

      # additional developer tooling
      github-cli

      # games
      lunar-client
      steam
      heroic
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.opencode.enable = true;

  programs.obs-studio = {
     enable = true;
     
     package = (
        pkgs.obs-studio.override {
           cudaSupport = true;
        }
     );

     plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
        obs-vkcapture
     ];
  };

  programs.home-manager.enable = true;
}

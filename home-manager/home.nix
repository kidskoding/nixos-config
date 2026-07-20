{ config, pkgs, ... }:

{
  imports = [
    ./modules
    ./git.nix
    ./fish.nix
    ./fonts.nix
    ./themes
  ];

  home.username = "anirudh";
  home.homeDirectory = "/home/anirudh";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
      # additional user system tools
      cava
      cliphist
      ripgrep
      tree
      wl-clipboard

      # languages
      dotnet-sdk_10
      go
      jdk21
      lua
      ruby
      zig

      # core developer tools
      bear
      bun
      cmake
      nodejs
      uv
      xmake

      # niche c / c++ tooling
      clang-tools
      ninja
      pkg-config
      valgrind

      # additional developer tooling
      github-cli

      # applications
      discord
      firefox
      spotify

      # games
      heroic
      lunar-client
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

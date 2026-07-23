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

  home.sessionPath = [
    "${config.home.homeDirectory}/.config/emacs/bin"
  ];

  home.packages = with pkgs; [
      # additional user system tools
      cava
      cliphist
      fd
      jq
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

      # lsps
      gopls
      jdt-language-server
      lua-language-server
      nixd
      omnisharp-roslyn
      pyright
      ruby-lsp
      typescript-language-server
      zls

      # core developer tools
      bear
      bun
      cmake
      libtool
      nodejs
      uv
      xmake

      # niche c / c++ tooling
      clang-tools
      ninja
      pkg-config
      valgrind

      # additional developer tooling
      bacon
      emacs-nox
      github-cli
      mdbook
      mdbook-mermaid
      tmux

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

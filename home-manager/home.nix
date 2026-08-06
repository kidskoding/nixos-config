{ config, pkgs, ... }:

{
  imports = [
    ./modules
    ./git.nix
    ./fish.nix
    ./fonts.nix
    ./themes
  ];

  # theme.name = "kanagawa";
  theme.name = "gruvbox-dark";

  # home.username and home.homeDirectory come from the NixOS module
  # (users.users.anirudh), which sets them unconditionally.
  home.stateVersion = "26.05";

  home.sessionPath = [
    "${config.home.homeDirectory}/.config/emacs/bin"
  ];

  home.packages = with pkgs; [
    # additional user system tools
    cava
    cliphist
    cowsay
    fd
    jq
    ripgrep
    tickrs
    tree
    wl-clipboard

    # languages
    dotnet-sdk_10
    go
    jdk21
    lua
    ruby
    zig

    # lsps / formatters / linters
    jdt-language-server
    lua-language-server
    nixd
    nixfmt
    omnisharp-roslyn
    pyright
    ruby-lsp
    shellcheck
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
    air
    bacon
    claude-agent-acp
    codex-acp
    emacs-unstable
    github-cli
    mdbook
    mdbook-mermaid
    pandoc
    rustlings
    tmux
    texliveMedium

    (runCommand "epdfinfo" { } ''
      mkdir -p $out/bin
      ln -s ${emacsPackages.pdf-tools}/share/emacs/site-lisp/elpa/pdf-tools-*/epdfinfo $out/bin/epdfinfo
    '')

    # applications
    discord
    firefox
    spotify

    # gaming
    bottles
    heroic
    lunar-client
    lutris
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

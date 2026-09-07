{ config, pkgs, inputs, ... }:

{
  imports = [
    ./fish.nix
    ./fonts.nix
    ./git.nix
    ./obs.nix
    ./ssh.nix
    ./thunderbird.nix
    ./zen.nix
    inputs.gruvbox.homeModules.default

    ./alacritty
    ./emacs
    ./niri
    ./noctalia
    ./wallpaper

    ./fastfetch.nix
    ./mangohud.nix
    ./starship.nix
    ./tickrs.nix
    ./zellij.nix
  ];

  gruvbox = {
    enable = true;
    accent = "yellow";
  };

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
    elmPackages.elm
    go
    jdk21
    julia
    lua
    php
    phpPackages.composer
    ruby
    zig

    # lsps / formatters / linters
    elmPackages.elm-language-server
    gopls
    graphql-language-service-cli
    intelephense
    jdt-language-server
    kotlin-language-server
    lua-language-server
    nixd
    nixfmt
    omnisharp-roslyn
    pyright
    ruby-lsp
    shellcheck
    terraform-ls
    typescript-language-server
    vscode-langservers-extracted
    yaml-language-server
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
    github-cli
    mdbook
    mdbook-mermaid
    pandoc
    (texliveMedium.withPackages (ps: with ps; [ wrapfig capt-of ]))

    (runCommand "epdfinfo" { } ''
      mkdir -p $out/bin
      ln -s ${emacsPackages.pdf-tools}/share/emacs/site-lisp/elpa/pdf-tools-*/epdfinfo $out/bin/epdfinfo
    '')

    # applications
    basalt
    discord
    gum
    obsidian
    ruffle
    spotify

    # gaming
    bottles
    dolphin-emu
    heroic
    lunar-client
    lutris
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.opencode.enable = true;
}

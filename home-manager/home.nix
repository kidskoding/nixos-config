{ config, pkgs, ... }:

{
  imports = [
    ./programs
    ./themes
    ./wallpaper
  ];

  theme.name = "gruvbox-dark";
  theme.fontFamily = "Terminess Nerd Font Mono";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    # additional user system tools
    cliphist
    fd
    jq
    ripgrep
    tree
    wl-clipboard

    # languages
    dotnet-sdk_10
    dune_3
    elmPackages.elm
    go
    jdk21
    (julia.withPackages [ "LanguageServer" ])
    lua
    ocaml
    php
    phpPackages.composer
    ruby
    scala_3
    swift
    swiftpm
    typst
    zig

    # lsps / formatters / linters
    elmPackages.elm-language-server
    gopls
    graphql-language-service-cli
    intelephense
    jdt-language-server
    kotlin-language-server
    lua-language-server
    metals
    nixd
    nixfmt
    ocamlformat
    ocamlPackages.ocaml-lsp
    omnisharp-roslyn
    ruby-lsp
    ruff
    shellcheck
    sourcekit-lsp
    stylelint
    terraform-ls
    tinymist
    ty
    typescript-language-server
    typstyle
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
    devenv
    duckdb
    github-cli
    mdbook
    mdbook-mermaid
    pandoc

    # desktop applications
    basalt
    discord
    myx
    obsidian
    ruffle
    spotify

    # gaming
    bottles
    dolphin-emu
    heroic
    lunar-client
    lutris

    # other really cool stuff!!
    cava
    cowsay
    fortune
    gum
    pipes
    presenterm
    tickrs
    timr-tui
    wtf

    # fonts
    nerd-fonts.symbols-only
    nerd-fonts.terminess-ttf
    symbola
  ];
}

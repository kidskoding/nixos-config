{ config, pkgs, ... }:

{
  imports = [
    ./programs
    ./themes
    ./wallpaper
  ];

  theme.name = "gruvbox-dark";
  theme.fontFamily = "GohuFont 14 Nerd Font Mono";

  home.stateVersion = "26.05";
  home.sessionPath = [
    "${config.home.homeDirectory}/.config/emacs/bin"
  ];

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
    julia
    lua
    ocaml
    php
    phpPackages.composer
    ruby
    scala_3
    swift
    swiftpm
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
    ty
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
    devenv
    duckdb
    github-cli
    mdbook
    mdbook-mermaid
    pandoc
    (texliveMedium.withPackages (ps: with ps; [ wrapfig capt-of ]))

    (runCommand "epdfinfo" { } ''
      mkdir -p $out/bin
      ln -s ${emacsPackages.pdf-tools}/share/emacs/site-lisp/elpa/pdf-tools-*/epdfinfo $out/bin/epdfinfo
    '')

    # desktop applications
    basalt
    discord
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
    wtf

    # fonts
    nerd-fonts.gohufont
    nerd-fonts.symbols-only
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}

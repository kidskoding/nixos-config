{ config, pkgs, ... }:

{
  imports = [
    ./programs
    ./themes
    ./wallpaper
    ./fonts.nix
  ];

  theme.name = "gruvbox-dark";

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
    ruby-lsp
    ruff
    shellcheck
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
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.opencode.enable = true;
}

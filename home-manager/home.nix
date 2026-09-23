{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./programs
    ./themes
    ./wallpaper
  ];

  theme.name = "gruvbox-dark";
  theme.fontFamily = "Terminess Nerd Font Mono";

  home.stateVersion = "26.05";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.packages = with pkgs; [
    # additional user system tools
    cliphist
    fd
    jq
    ripgrep
    tree
    tree-sitter
    wl-clipboard

    # languages
    dotnet-sdk_10
    dune_3
    elmPackages.elm
    go
    jdk21
    (julia.withPackages ["LanguageServer"])

    lua
    luarocks
    luaPackages.fennel

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
    alejandra
    dockerfile-language-server
    elmPackages.elm-language-server
    fennel-ls
    fish-lsp
    fnlfmt
    gopls
    graphql-language-service-cli
    intelephense
    jdt-language-server
    kotlin-language-server
    lua-language-server
    marksman
    metals
    nixd
    ocamlformat
    ocamlPackages.ocaml-lsp
    omnisharp-roslyn
    ruby-lsp
    ruff
    shellcheck
    sourcekit-lsp
    sqls
    stylelint
    stylua
    taplo
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
    difftastic
    duckdb
    github-cli
    mdbook
    mdbook-mermaid
    pandoc

    # applications
    basalt
    discord
    harlequin
    myx
    obsidian
    ruffle
    spotify
    teams-for-linux
    zathura

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

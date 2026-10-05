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
    TSDK = "${pkgs.typescript_5}/lib/node_modules/typescript/lib";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
    };
  };

  home.packages = with pkgs; [
    # additional user system tools
    cliphist
    fd
    jq
    ripgrep
    tree
    tree-sitter
    websocat
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
    mdx-language-server
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
    typescript
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
    cargo-seek
    claude-agent-acp
    codex-acp
    devenv
    duckdb
    evcxr
    github-cli
    mdbook
    mdbook-mermaid
    pandoc

    # applications
    basalt
    discord
    harlequin
    myx
    neovim-unwrapped
    obsidian
    ruffle
    spotify
    teams-for-linux
    wineWow64Packages.stable
    winetricks
    zathura
    zoom-us

    # gaming
    bottles
    dolphin-emu
    heroic
    lunar-client
    lutris

    # other really cool stuff!!
    asciiquarium-transparent
    cava
    cowsay
    fortune
    ghostscript
    gum
    imagemagick
    mermaid-cli
    pipes
    presenterm
    tickrs
    timr-tui
    tldr
    wtf

    # user utilities
    rclone
    sshfs

    # fonts
    nerd-fonts.symbols-only
    nerd-fonts.terminess-ttf
    symbola
    corefonts
  ];
}

{ config, pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./fonts.nix
    ./git.nix
    ./obs.nix
    ./ssh.nix
    ./themes

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

  theme.name = "gruvbox-dark";

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
    discord
    ruffle
    spotify

    # gaming
    bottles
    dolphin-emu
    heroic
    lunar-client
    lutris

    # other cool stuff!
    gum
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  
  programs.opencode.enable = true;

  # zen draws its own gtk file dialog unless the portal picker is forced on
  # (default 2 = "auto" only fires under flatpak/snap or GTK_USE_PORTAL=1).
  # profile dir is machine-local -- see ~/.config/zen/profiles.ini if it changes.
  home.file.".config/zen/xez3wz0f.Default Profile/user.js".text = ''
    user_pref("widget.use-xdg-desktop-portal.file-picker", 1);
  '';
}

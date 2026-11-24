# user level configuration via home manager
{
  config,
  inputs,
  pkgs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
in {
  programs.fish.shellAliases.rebuild = "${config.my.flakeDir}/scripts/rebuild.sh";

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = config.my.flakeDir;
  };

  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.cava.enable = true;

  # direnv: auto load / unload project-specific env variables upon `cd` / `..` respectively !!
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # tealdeer: a fast tldr client !!
  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
  };

  home.packages = with pkgs; [
    # additional user system tools
    p7zip
    fd
    ffmpeg
    imagemagick
    jq
    just
    poppler-utils
    resvg
    ripgrep
    tree
    tree-sitter
    websocat
    zoxide

    # terminal apps
    basalt
    harlequin
    myx

    # cloud
    awscli2
    databricks-cli
    terraform

    # misc
    stripe-cli
    magic-wormhole-rs
    rclone
    sshfs
    asciiquarium-transparent
    cbonsai
    cowsay
    dua
    fortune
    ghostscript
    gum
    mermaid-cli
    pipes
    presenterm
    tickrs
    timr-tui
    tty-clock
    wtf

    inputs.aoc-cli.packages.${system}.default
    inputs.matui.packages.${system}.default
    inputs.toofan.packages.${system}.default
  ];
}

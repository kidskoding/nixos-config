{...}: {
  flake.homeModules.base = {pkgs, ...}: {
    programs.btop.enable = true;

    programs.cava.enable = true;

    home.packages = with pkgs; [
      # terminal apps
      basalt
      harlequin
      myx

      # other really cool stuff!!
      asciiquarium-transparent
      cbonsai
      cowsay
      dua
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
      tty-clock
      wtf

      # user utilities
      magic-wormhole-rs
      rclone
      sshfs

      # cloud
      awscli2
      terraform

      # other
      ncspot
    ];
  };
}

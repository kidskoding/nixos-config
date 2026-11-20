{...}: {
  flake.homeModules.base = {pkgs, ...}: {
    programs.btop.enable = true;

    programs.cava.enable = true;

    programs.tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };

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
      tty-clock
      wtf

      # user utilities
      magic-wormhole-rs
      rclone
      sshfs

      # cloud
      awscli2
      databricks-cli
      terraform

      # misc
      stripe-cli
    ];
  };
}

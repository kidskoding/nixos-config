{ lib, pkgs, ... }:

{
  options.theme.fontFamily = lib.mkOption {
    type = lib.types.str;
    default = "Terminess Nerd Font Mono";
    description = "font family i use across my app configs!";
  };

  config.home.packages = with pkgs; [
    nerd-fonts.terminess-ttf
    nerd-fonts.symbols-only
  ];
}

{ lib, pkgs, ... }:

{
  options.theme.fontFamily = lib.mkOption {
    type = lib.types.str;
    default = "GohuFont14 Nerd Font Mono";
    description = "font family i use across my app configs!";
  };

  config.home.packages = with pkgs; [
    nerd-fonts.gohufont
    nerd-fonts.symbols-only
  ];
}

{ pkgs, ... }:

let
  emacs = pkgs.emacs-unstable.pkgs.withPackages (
    epkgs: with epkgs; [ treesit-grammars.with-all-grammars ]
  );
in

{
  home.packages = [ emacs pkgs.zathura ];

  services.emacs = {
    enable = true;
    package = emacs;
    socketActivation.enable = true;
  };

  systemd.user.services.emacs.Service.Environment = [ "COLORTERM=truecolor" ];

  home.sessionVariables = {
    EDITOR = "emacsclient -nw";
    VISUAL = "emacsclient -nw";
  };

  xdg.configFile."doom" = {
    source = ./doom.d;
    recursive = true;
  };
}

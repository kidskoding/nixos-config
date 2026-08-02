{ pkgs, ... }:
{
  home.sessionVariables = {
    EDITOR = ''emacsclient -nw -a ""'';
    VISUAL = ''emacsclient -nw -a ""'';
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacs-unstable-nox;
  };

  xdg.configFile."doom" = {
    source = ./doom.d;
    recursive = true;
  };
}

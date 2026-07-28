{ ... }:
{
  home.sessionVariables = {
    EDITOR = ''emacsclient -nw -a ""'';
    VISUAL = ''emacsclient -nw -a ""'';
  };

  xdg.configFile."doom" = {
    source = ./doom.d;
    recursive = true;
  };
}

{ ... }:

{
  home.sessionVariables = {
    EDITOR = "emacsclient -nw";
    VISUAL = "emacsclient -nw";
  };

  xdg.configFile."doom" = {
    source = ./doom.d;
    recursive = true;
  };
}

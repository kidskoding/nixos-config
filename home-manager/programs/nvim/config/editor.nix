{
  globals.mapleader = " ";

  opts = {
    clipboard = "unnamedplus";
    expandtab = true;
    number = true;
    shiftwidth = 4;
    softtabstop = 4;
    tabstop = 4;
  };

  clipboard.providers = {
    wl-copy.enable = true;
  };

  diagnostic.settings.virtual_lines.current_line = true;
}

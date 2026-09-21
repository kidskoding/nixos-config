{
  imports = [
    ./completion.nix
    ./editor.nix
    ./lsp.nix
    ./plugins.nix
  ];

  withPython3 = false;
  withRuby = false;

  highlightOverride = {
    "@punctuation.bracket".link = "Normal";
    "@punctuation.delimiter".link = "Normal";
  };

  colorschemes.gruvbox = {
    enable = true;

    settings.italic = {
      comments = false;
      emphasis = false;
      folds = false;
      operators = false;
      strings = false;
    };
  };
}

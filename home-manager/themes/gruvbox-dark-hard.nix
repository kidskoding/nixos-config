(import ./gruvbox-dark.nix) // {
  colors = (import ./gruvbox-dark.nix).colors // {
    bg = "#1d2021";
    black = "#1d2021";
  };
}

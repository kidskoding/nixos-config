(import ./gruvbox-light.nix)
// {
  colors =
    (import ./gruvbox-light.nix).colors
    // {
      bg = "#f9f5d7";
      black = "#f9f5d7";
    };
}

(import ./gruvbox-light.nix)
// {
  colors =
    (import ./gruvbox-light.nix).colors
    // {
      bg = "#f2e5bc";
      black = "#f2e5bc";
    };
}

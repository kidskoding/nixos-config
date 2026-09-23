(import ./gruvbox-dark.nix)
// {
  colors =
    (import ./gruvbox-dark.nix).colors
    // {
      bg = "#32302f";
      black = "#32302f";
    };
}

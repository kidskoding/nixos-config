{ ... }:

{
  programs.wofi = {
    enable = true;

    settings = {
      "matching-mode" = "fuzzy";
      allow_images = true;
      image_size = 32;
      mode = "drun";
      hide_scroll = true;
      insensitive = true;
      gtk_dark = true;
    };

    style = builtins.readFile ./style.css;
  };
}

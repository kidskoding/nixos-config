{
  plugins = {
    friendly-snippets.enable = true;

    blink-cmp = {
      enable = true;

      settings.keymap = {
        preset = "none";

        "<C-n>" = [
          "insert_next"
          "fallback"
        ];

        "<C-p>" = [
          "insert_prev"
          "fallback"
        ];

        "<Down>" = [
          "select_next"
          "fallback"
        ];

        "<Up>" = [
          "select_prev"
          "fallback"
        ];

        "<C-y>" = [
          "accept"
          "fallback"
        ];

        "<Tab>" = [
          "accept"
          "fallback"
        ];

        "<C-e>" = [
          "cancel"
          "fallback"
        ];
      };
    };
  };
}

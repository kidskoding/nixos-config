{
  plugins = {
    friendly-snippets.enable = true;

    blink-cmp = {
      enable = true;

      settings.sources = {
        per_filetype = {
          sql = [
            "dadbod"
            "snippets"
            "buffer"
          ];
          mysql = [
            "dadbod"
            "snippets"
            "buffer"
          ];
          plsql = [
            "dadbod"
            "snippets"
            "buffer"
          ];
        };

        providers.dadbod = {
          name = "Dadbod";
          module = "vim_dadbod_completion.blink";
        };
      };

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

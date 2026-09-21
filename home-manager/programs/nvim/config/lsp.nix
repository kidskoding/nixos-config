{
  plugins.lsp = {
    enable = true;
    servers = {
      clangd.enable = true;
      cssls.enable = true;
      dockerls.enable = true;
      elmls.enable = true;
      eslint.enable = true;
      fish_lsp.enable = true;
      gopls.enable = true;
      graphql.enable = true;
      html.enable = true;

      intelephense = {
        enable = true;
        package = null;
      };

      jdtls.enable = true;
      jsonls.enable = true;

      julials = {
        enable = true;
        package = null;
      };

      kotlin_language_server.enable = true;

      lua_ls = {
        enable = true;
        settings.diagnostics.globals = [ "vim" ];
      };

      marksman.enable = true;
      metals.enable = true;
      nixd.enable = true;
      ocamllsp.enable = true;
      omnisharp.enable = true;
      ruby_lsp.enable = true;

      rust_analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;

        settings = {
          cargo.allFeatures = true;
          check.command = "clippy";
        };
      };

      sourcekit.enable = true;
      sqls.enable = true;
      taplo.enable = true;
      terraformls.enable = true;

      tinymist = {
        enable = true;
        settings = {
          exportPdf = "onType";
          formatterMode = "typstyle";
          lint.enabled = true;
          lint.when = "onSave";
        };
      };

      ts_ls.enable = true;
      ty.enable = true;
      yamlls.enable = true;
      zls.enable = true;
    };
  };
}

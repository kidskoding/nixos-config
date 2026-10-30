{inputs, ...}: {
  flake.homeModules.kidskoding = {pkgs, ...}: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    home.sessionVariables = {
      TSDK = "${pkgs.typescript_5}/lib/node_modules/typescript/lib";

      # use old way for initializing projects with uv!
      UV_NO_PROJECT = 1;
    };

    # go install puts binaries here (myleet, etc.)
    home.sessionPath = ["$HOME/go/bin"];

    home.packages = with pkgs; [
      # rust nightly toolchain
      (inputs.fenix.packages.${system}.latest.withComponents [
        "cargo"
        "clippy"
        "rust-analyzer"
        "rust-src"
        "rustc"
        "rustfmt"
      ])
      bacon
      cargo-generate
      cargo-info
      cargo-seek
      irust
      rusty-man

      # go
      go
      gopls

      # web
      bun
      nodejs
      typescript
      inputs.nix-vite-plus.packages.${system}.default
      graphql-language-service-cli
      mdx-language-server
      vscode-langservers-extracted
      prettier
      stylelint

      # python
      uv
      ruff
      ty

      # c / c++
      bear
      cmake
      libtool
      xmake
      clang-tools
      ninja
      pkg-config
      valgrind
      doxygen

      # jvm
      jdk21
      gradle
      scala_3
      jdt-language-server
      kotlin-language-server
      metals

      # ocaml
      ocaml
      dune_3
      ocamlPackages.ocaml-lsp
      ocamlformat

      # lua / fennel
      lua
      luarocks
      luaPackages.fennel
      fennel-ls
      lua-language-server
      fnlfmt
      stylua

      # nix
      nixd
      alejandra
      devenv

      # docs
      typst
      tinymist
      typstyle
      marksman
      mdbook
      mdbook-mermaid
      pandoc

      # other languages
      dotnet-sdk_11
      omnisharp-roslyn
      elmPackages.elm
      elmPackages.elm-language-server
      julia
      php
      phpPackages.composer
      intelephense
      ruby
      ruby-lsp
      swift
      swiftpm
      sourcekit-lsp
      zig
      zls

      # shell, config, and infra files
      dockerfile-language-server
      fish-lsp
      shellcheck
      sqls
      taplo
      terraform-ls
      yaml-language-server
      duckdb
    ];
  };
}

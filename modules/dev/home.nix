# one group per language; a host picks `dev` for all of them, or dev-core plus the languages it needs
{
  inputs,
  lib,
  self,
  ...
}: let
  groups = [
    "dev-core"
    "dev-rust"
    "dev-go"
    "dev-web"
    "dev-python"
    "dev-c"
    "dev-jvm"
    "dev-ocaml"
    "dev-lua"
    "dev-docs"
    "dev-other"
  ];
in {
  flake.homeModules.dev.imports = map (name: self.homeModules.${name}) groups;

  flake.nixosModules = lib.genAttrs (["dev"] ++ groups) (name: {
    home-manager.sharedModules = [self.homeModules.${name}];
  });

  # editors (nvim, helix) also join this group
  flake.homeModules.dev-core = {pkgs, ...}: {
    my.caches = [
      # devenv cache
      {
        url = "https://devenv.cachix.org";
        key = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
      }
    ];

    home.packages = with pkgs; [
      # nix
      nixd
      alejandra
      devenv

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

  flake.homeModules.dev-rust = {pkgs, ...}: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
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
    ];
  };

  flake.homeModules.dev-go = {pkgs, ...}: {
    # go install puts binaries here (myleet, etc.)
    home.sessionPath = ["$HOME/go/bin"];

    home.packages = with pkgs; [
      go
      gopls
    ];
  };

  flake.homeModules.dev-web = {pkgs, ...}: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    home.sessionVariables.TSDK = "${pkgs.typescript_5}/lib/node_modules/typescript/lib";

    home.packages = with pkgs; [
      bun
      nodejs
      typescript
      inputs.nix-vite-plus.packages.${system}.default
      graphql-language-service-cli
      mdx-language-server
      vscode-langservers-extracted
      prettier
      stylelint
    ];
  };

  flake.homeModules.dev-python = {pkgs, ...}: {
    # use old way for initializing projects with uv!
    home.sessionVariables.UV_NO_PROJECT = 1;

    home.packages = with pkgs; [
      uv
      ruff
      ty
    ];
  };

  flake.homeModules.dev-c = {pkgs, ...}: {
    # c / c++
    home.packages = with pkgs; [
      bear
      cmake
      libtool
      xmake
      clang-tools
      ninja
      pkg-config
      valgrind
      doxygen
    ];
  };

  flake.homeModules.dev-jvm = {pkgs, ...}: {
    home.packages = with pkgs; [
      jdk21
      gradle
      scala_3
      jdt-language-server
      kotlin-language-server
      metals
    ];
  };

  flake.homeModules.dev-ocaml = {pkgs, ...}: {
    home.packages = with pkgs; [
      ocaml
      dune_3
      ocamlPackages.ocaml-lsp
      ocamlformat
    ];
  };

  flake.homeModules.dev-lua = {pkgs, ...}: {
    # lua / fennel
    home.packages = with pkgs; [
      lua
      luarocks
      luaPackages.fennel
      fennel-ls
      lua-language-server
      fnlfmt
      stylua
    ];
  };

  flake.homeModules.dev-docs = {pkgs, ...}: {
    home.packages = with pkgs; [
      typst
      tinymist
      typstyle
      marksman
      mdbook
      mdbook-mermaid
      pandoc
    ];
  };

  flake.homeModules.dev-other = {pkgs, ...}: {
    home.packages = with pkgs; [
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
    ];
  };
}

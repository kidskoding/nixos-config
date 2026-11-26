# one group per language; a host picks `dev` for all of them, or dev-core plus the languages it needs
{
  inputs,
  self,
  ...
}: {
  flake.homeModules.dev.imports = [
    self.homeModules.dev-core
    self.homeModules.dev-rust
    self.homeModules.dev-go
    self.homeModules.dev-web
    self.homeModules.dev-python
    self.homeModules.dev-c
    self.homeModules.dev-jvm
    self.homeModules.dev-ocaml
    self.homeModules.dev-lua
    self.homeModules.dev-docs
    self.homeModules.dev-other
  ];

  flake.nixosModules.dev.home-manager.sharedModules = [self.homeModules.dev];
  flake.nixosModules.dev-core.home-manager.sharedModules = [self.homeModules.dev-core];
  flake.nixosModules.dev-rust.home-manager.sharedModules = [self.homeModules.dev-rust];
  flake.nixosModules.dev-go.home-manager.sharedModules = [self.homeModules.dev-go];
  flake.nixosModules.dev-web.home-manager.sharedModules = [self.homeModules.dev-web];
  flake.nixosModules.dev-python.home-manager.sharedModules = [self.homeModules.dev-python];
  flake.nixosModules.dev-c.home-manager.sharedModules = [self.homeModules.dev-c];
  flake.nixosModules.dev-jvm.home-manager.sharedModules = [self.homeModules.dev-jvm];
  flake.nixosModules.dev-ocaml.home-manager.sharedModules = [self.homeModules.dev-ocaml];
  flake.nixosModules.dev-lua.home-manager.sharedModules = [self.homeModules.dev-lua];
  flake.nixosModules.dev-docs.home-manager.sharedModules = [self.homeModules.dev-docs];
  flake.nixosModules.dev-other.home-manager.sharedModules = [self.homeModules.dev-other];

  flake.homeModules.dev-core = {pkgs, ...}: {
    home.packages = with pkgs; [
      # nix
      nixd
      alejandra
      devenv

      # shell, config, and infra files
      docker-compose-language-service
      dockerfile-language-server
      fish-lsp
      shellcheck
      sqls
      taplo
      terraform-ls
      yaml-language-server
      duckdb
      autotools-language-server
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

      # additional amazing rust binaries!
      bacon
      cargo-chef
      cargo-flamegraph
      cargo-generate
      cargo-info
      cargo-lambda
      cargo-seek
      irust
      rusty-man
      # trunk
      wasm-pack
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
      astro-language-server
    ];
  };

  flake.homeModules.dev-python = {pkgs, ...}: {
    # use old way for initializing projects with uv!
    home.sessionVariables.UV_NO_PROJECT = 1;

    home.packages = with pkgs; [
      uv
      ruff
      ty
      kaggle
      jupyter
    ];
  };

  flake.homeModules.dev-c = {pkgs, ...}: {
    # c / c++
    home.packages = with pkgs; [
      bear
      cmake
      libtool
      xmake
      (lib.hiPrio clang-tools)
      ninja
      pkg-config
      valgrind
      doxygen
      neocmakelsp
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
      markdown-oxide
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

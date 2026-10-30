{
  description = "kidskoding.nvim: a minimal Neovim config written in Fennel";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs) lib;
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = f:
      lib.genAttrs systems (system:
        f (import nixpkgs {
          inherit system;
          config.allowUnfreePredicate = pkg: lib.getName pkg == "intelephense";
        }));
  in {
    packages = forAllSystems (pkgs: let
      config = lib.fileset.toSource {
        root = ./.;
        fileset = lib.fileset.unions [
          ./init.lua
          ./fnl
          ./flsproject.fnl
          ./nvim-pack-lock.json
        ];
      };

      deps = builtins.filter (lib.meta.availableOn pkgs.stdenv.hostPlatform) (with pkgs; [
        # plugin installs, parsers, pickers
        curl
        git
        gnutar
        ripgrep
        fd
        stdenv.cc
        tree-sitter

        # plugin tools
        difftastic
        lazygit
        websocat
        zathura

        # formatters
        alejandra
        fnlfmt
        ruff
        stylua
        typstyle

        # lsps
        clang-tools
        dockerfile-language-server
        elmPackages.elm-language-server
        fennel-ls
        fish-lsp
        gopls
        graphql-language-service-cli
        intelephense
        jdt-language-server
        (julia.withPackages ["LanguageServer"])
        kotlin-language-server
        lua-language-server
        marksman
        mdx-language-server
        metals
        nixd
        ocamlPackages.ocaml-lsp
        omnisharp-roslyn
        ruby-lsp
        rust-analyzer
        sourcekit-lsp
        sqls
        taplo
        terraform-ls
        tinymist
        ty
        typescript
        vscode-langservers-extracted
        yaml-language-server
        zls
      ]);
    in {
      default = pkgs.writeShellApplication {
        name = "nvim";
        text = ''
          export PATH="''${PATH:+$PATH:}${lib.makeBinPath deps}"
          export NVIM_APPNAME="''${NVIM_APPNAME:-nvim}"
          export TSDK="''${TSDK:-${pkgs.typescript_5}/lib/node_modules/typescript/lib}"

          dir="''${XDG_CONFIG_HOME:-$HOME/.config}/$NVIM_APPNAME"
          if [ -L "$dir" ] && [ ! -e "$dir" ]; then
            echo "error: $dir is a broken symlink" >&2
            exit 1
          elif [ ! -e "$dir" ]; then
            ${pkgs.coreutils}/bin/mkdir -p "$dir"
            ${pkgs.coreutils}/bin/cp -rT --no-preserve=mode ${config} "$dir"
          fi

          exec ${pkgs.neovim-unwrapped}/bin/nvim "$@"
        '';
      };
    });

    apps = forAllSystems (pkgs: {
      default = {
        type = "app";
        program = lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };
    });
  };
}

{
  description = "kidskoding.nvim: a minimal Neovim config written in Lua";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {nixpkgs, ...}: let
    inherit (nixpkgs) lib;
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = f:
      lib.genAttrs systems (system:
        f (import nixpkgs {
          inherit system;
          config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["intelephense" "copilot-language-server"];
        }));
  in {
    packages = forAllSystems (pkgs: let
      config = lib.fileset.toSource {
        root = ./.;
        fileset = lib.fileset.unions [
          ./init.lua
          ./lua
          ./.stylua.toml
        ];
      };

      deps = builtins.filter (lib.meta.availableOn pkgs.stdenv.hostPlatform) (import ./deps.nix pkgs);
    in {
      default = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
        plugins = import ./plugins.nix pkgs.vimPlugins;
        wrapRc = false;
        wrapperArgs = [
          "--suffix"
          "PATH"
          ":"
          (lib.makeBinPath deps)
          "--set-default"
          "TSDK"
          "${pkgs.typescript_5}/lib/node_modules/typescript/lib"
          "--run"
          ''dir="''${XDG_CONFIG_HOME:-$HOME/.config}/''${NVIM_APPNAME:-nvim}"; [ -e "$dir" ] || { mkdir -p "$dir" && cp -rT --no-preserve=mode ${config} "$dir"; }''
        ];
      };
    });
  };
}

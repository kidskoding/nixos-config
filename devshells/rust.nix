{
  pkgs,
  fenix,
}: let
  toolchain = fenix.combine [
    (fenix.stable.withComponents [
      "cargo"
      "clippy"
      "rust-analyzer"
      "rust-src"
      "rustc"
    ])
    fenix.complete.rustfmt
  ];
in
  pkgs.mkShell {
    packages =
      [toolchain]
      ++ (with pkgs; [
        bacon
        cargo-chef
        cargo-generate
        cargo-seek
        evcxr
        trunk
        wasm-pack
      ]);

    RUST_BACKTRACE = "1";
  }

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    aoc-cli
    bacon
    cargo-chef
    cargo-lambda
    evcxr
    mdbook
    mdbook-mermaid
    rustlings
    trunk
    wasm-pack
  ];

  home.sessionVariables = {
    RUST_BACKTRACE = "1";
  };
}

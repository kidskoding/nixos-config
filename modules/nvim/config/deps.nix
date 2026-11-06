pkgs:
with pkgs; [
  # plugin downloads, pickers
  curl
  git
  ripgrep
  fd

  # plugin tools
  difftastic
  gh
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
]

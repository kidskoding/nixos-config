vimPlugins:
with vimPlugins; [
  # color themes!
  gruvbox-nvim
  gruvbox-material

  # ui
  lualine-nvim
  nvim-web-devicons
  bufferline-nvim
  nvim-highlight-colors
  which-key-nvim

  # lsp, treesitter, completion, format
  nvim-lspconfig
  trouble-nvim
  (nvim-treesitter.withPlugins (p:
    with p; [
      bash
      css
      fennel
      fish
      go
      html
      javascript
      json
      nix
      python
      rust
      scss
      svelte
      toml
      tsx
      typescript
      typst
      vue
      yaml
    ]))
  nvim-treesitter-context
  blink-cmp
  friendly-snippets
  conform-nvim

  # editor
  nvim-autopairs
  guess-indent-nvim
  nvim-surround
  auto-save-nvim
  rainbow_csv
  render-markdown-nvim
  plenary-nvim
  oil-nvim
  harpoon2

  # git, snacks
  gitsigns-nvim
  snacks-nvim
  todo-comments-nvim
  persistence-nvim

  # languages
  rustaceanvim
  crates-nvim
  typst-preview-nvim
  obsidian-nvim

  # test
  nvim-nio
  neotest
  neotest-python
  neotest-golang

  # database
  vim-dadbod
  vim-dadbod-ui
  vim-dadbod-completion

  # ai, misc
  claudecode-nvim
  sidekick-nvim
  cord-nvim
]

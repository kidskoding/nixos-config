# kidskoding.nvim

a minimal Neovim config written in Fennel: compiled by [hotpot.nvim](https://github.com/rktjmp/hotpot.nvim)!

plugins are managed by Neovim's built-in `vim.pack`!

## Requirements

- Neovim 0.12+
- git, tar, curl, a C compiler, and the tree-sitter CLI (to build parsers)
- ripgrep (for snacks pickers)
- fennel-ls and fnlfmt (for Fennel editing)
- a Nerd Font (icons)

## Install

```sh
git clone https://github.com/kidskoding/kidskoding.nvim ~/.config/nvim
nvim
```

plugins install on first launch. `:checkhealth` will spot missing tools!

# kidskoding.nvim

a minimal Neovim config written in Fennel: compiled by [hotpot.nvim](https://github.com/rktjmp/hotpot.nvim)!

plugins are managed by Neovim's built-in `vim.pack`!

![](screenshots/splash.png)

![](screenshots/file.png)

## Requirements

- Neovim 0.12+
- git, tar, curl, a C compiler, and the tree-sitter CLI (to build parsers)
- ripgrep (for snacks pickers)
- fennel-ls and fnlfmt (for Fennel editing)
- a Nerd Font (for icons)

**Optional**: I highly recommend installing [nix (the package manager)](https://nixos.org/download/)
instead: it sets up every requirement above (except the font) for you. see [Nix](#nix)!

## Install

```sh
git clone https://codeberg.org/kidskoding/kidskoding.nvim ~/.config/nvim
nvim
```

plugins install on first launch, use `:checkhealth` to spot any missing tools and ensure the config is in good shape!

## Nix

this repo includes a flake that bundles Neovim with every tool, LSP, and formatter, making the config ready to use in one command!

```sh
nix run git+https://codeberg.org/kidskoding/kidskoding.nvim
```

the first run copies the config into `~/.config/nvim` if nothing is there yet (an existing config is used as is). try it in a separate, clean profile with:

```sh
NVIM_APPNAME=nvim-test nix run git+https://codeberg.org/kidskoding/kidskoding.nvim
```

you still need a Nerd Font for icons!

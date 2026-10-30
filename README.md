# nixos-config

my nixos config!! it sets up two laptops running nixos. the same shell,
editor and tools also install on any other linux machine with nix (wsl, other
distros) through home-manager, without nixos.

![fastfetch](screenshots/thinkpad/1-fetch.png)

<details>
<summary>more screenshots</summary>

![neovim and btop](screenshots/thinkpad/2-nvim-btop.png)
![cbonsai, tty-clock and pipes](screenshots/thinkpad/3-bonsai-clock-pipes.png)
![control center](screenshots/thinkpad/4-control-center.png)
![launcher](screenshots/thinkpad/5-launcher.png)
![spotify and cava](screenshots/thinkpad/6-spotify-cava.png)
![overview](screenshots/thinkpad/7-overview.png)

</details>

## what's inside

| | |
|---|---|
| compositor | [niri](https://github.com/YaLTeR/niri) |
| shell / bar | [noctalia](https://github.com/noctalia-dev/noctalia) |
| theme | [stylix](https://github.com/nix-community/stylix), gruvbox dark |
| terminal | ghostty, fish, starship, zellij |
| editor | neovim nightly ([kidskoding.nvim](https://codeberg.org/kidskoding/kidskoding.nvim)), evil-helix as backup |
| secrets | [sops-nix](https://github.com/Mic92/sops-nix) |
| disks | [disko](https://github.com/nix-community/disko) |
| layout | [dendritic](https://github.com/mightyiam/dendritic), with [flake-parts](https://github.com/hercules-ci/flake-parts) + [import-tree](https://github.com/vic/import-tree) |

## machines

| name | what | config |
|---|---|---|
| `thinkpad` | daily driver laptop, amd | `modules/hosts/thinkpad.nix` |
| `victus` | gaming laptop, hybrid intel + nvidia graphics (prime offload), also for cuda | `modules/hosts/victus.nix` |
| `portable` | home-manager only, any linux with nix | `modules/homes/portable.nix` |

## layout

The config is split by feature, not by machine. Every `.nix` file under
`modules/` is loaded automatically, and each file adds its settings to a named
group, like `flake.homeModules.dev`. A machine is just a list of the groups it
wants. To see which group a file belongs to, read its first lines.

```
modules/
├── hosts/          nixos machines
├── homes/          home-manager-only machines
├── users/          which home groups the laptops get
├── shell/, git/, … features, one folder each
├── settings.nix    nix settings and binary caches
└── standalone.nix  home-manager without nixos (mkHome, standalone group)
hosts/              hardware-configuration.nix and disko.nix per laptop
templates/          flake templates for new projects
scripts/            rebuild helpers
```

### home groups

| group | what | used by |
|---|---|---|
| `base` | shell, git, cli tools, theme | every machine |
| `dev` | languages, neovim, helix | picked per machine |
| `agents` | coding agents and their config | picked per machine |
| `desktop`, `niri` | gui apps, compositor | both laptops |
| `gaming` | games | victus |
| `standalone` | fixes for running outside nixos (gpu drivers, nix itself) | every non-nixos machine |

### where to edit

- a tool: the file for its group
- a binary cache (prebuilt packages, so nothing compiles): add it to
  `my.caches` in the file whose packages need it
- the laptops' home groups: `modules/users/kidskoding.nix`
- a new non-nixos machine: copy `modules/homes/portable.nix`, rename the
  `homeConfigurations` entry, list its groups

## nixos

`rebuild.sh` formats changed nix files, switches to the new system, then
commits and pushes if the switch worked:

```sh
~/nixos/scripts/rebuild.sh              # thinkpad
HOST=victus ~/nixos/scripts/rebuild.sh  # victus
```

The `rebuild` fish alias runs the right one on each laptop. Neovim config
changes go upstream separately with `nvim-sync`.

## home-manager on a non-nixos machine

1. Install nix (multi-user):

   ```sh
   sh <(curl -L https://nixos.org/nix/install) --daemon
   ```

2. Enable flakes and trust your user, so the binary caches in this config
   work. Add to `/etc/nix/nix.conf` (use your account name), then restart the daemon:

   ```
   experimental-features = nix-command flakes
   trusted-users = root <your-user>
   ```

   ```sh
   sudo systemctl restart nix-daemon
   ```

3. Clone this repo to `~/home-manager` (the config expects that path):

   ```sh
   git clone https://codeberg.org/kidskoding/nixos-config.git ~/home-manager
   ```

4. First switch. `--impure` lets it read `$USER` and `$HOME`; `-b bak` renames
   existing dotfiles to `*.bak` instead of failing. The first build can take a
   while, because the extra caches only apply after this switch.

   ```sh
   nix run home-manager -- switch --impure -b bak --flake ~/home-manager#portable
   ```

5. Make fish the login shell:

   ```sh
   echo ~/.nix-profile/bin/fish | sudo tee -a /etc/shells
   chsh -s ~/.nix-profile/bin/fish
   ```

6. Optional, for GPU apps from nix (once per machine):

   ```sh
   sudo ~/.nix-profile/bin/non-nixos-gpu-setup
   ```

7. Log out and back in.

After that, `hm-rebuild` stages, formats, switches, then commits and pushes on
success.

## templates

Starting points for new projects. Each one builds the project with nix from
its lockfile:

| template | for |
|---|---|
| `crane` | rust (`Cargo.lock`) |
| `gomod2nix` | go (`go.sum`) |
| `uv2nix` | python (`uv.lock`) |
| `bun2nix` | bun (`bun.lock`) |
| `pnpm2nix` | pnpm (`pnpm-lock.yaml`) |
| `bundix` | ruby (`Gemfile.lock`) |
| `gradle2nix` | gradle (`gradle.lock`) |
| `elm2nix` | elm (`elm.json`) |

```sh
nix flake init -t git+https://codeberg.org/kidskoding/nixos-config#crane
```

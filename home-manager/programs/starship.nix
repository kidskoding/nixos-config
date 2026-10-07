{
  config,
  pkgs,
  ...
}: let
  c = config.lib.stylix.colors.withHashtag;
  bg = c.base01;
  pill = color: body: "[](${bg})[${body}](bold ${color} bg:${bg})[](${bg}) ";
in {
  programs.starship = {
    enable = true;

    settings = {
      format = "$os$username$hostname$directory$git_branch$git_status$nix_shell$all$cmd_duration$line_break$character";

      os = {
        disabled = false;
        format = pill c.base0D "$symbol";
      };

      username = {
        show_always = true;
        format = pill c.base0A "$user";
      };

      hostname = {
        ssh_only = true;
        format = pill c.base0B "$ssh_symbol$hostname";
        ssh_symbol = " ";
      };

      directory = {
        truncation_length = 3;
        format = pill c.base0C "$path$read_only";
        read_only = " 󰌾";
      };

      git_branch.format = pill c.base0E "$symbol$branch";

      git_status.format = "(${pill c.base08 "$all_status$ahead_behind"})";

      nix_shell.format = pill c.base0D "$symbol$state";

      cmd_duration.format = pill c.base09 "󱎫 $duration";

      character = {
        success_symbol = "[➜](bold ${c.base0D})";
        error_symbol = "[➜](bold ${c.base08})";
      };

      gcloud = {
        disabled = true;
        symbol = "  ";
      };

      aws.symbol = "  ";

      buf.symbol = " ";
      bun.symbol = " ";
      c.symbol = " ";
      cpp.symbol = " ";
      cmake.symbol = " ";
      conda.symbol = " ";
      crystal.symbol = " ";
      dart.symbol = " ";
      deno.symbol = " ";
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      fennel.symbol = " ";
      fossil_branch.symbol = " ";
      git_branch.symbol = " ";
      git_commit.tag_symbol = "  ";
      golang.symbol = " ";
      guix_shell.symbol = " ";
      haskell.symbol = " ";
      haxe.symbol = " ";
      hg_branch.symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      kotlin.symbol = " ";
      lua.symbol = " ";
      memory_usage.symbol = "󰍛 ";
      meson.symbol = "󰔷 ";
      nim.symbol = "󰆥 ";
      nix_shell.symbol = " ";
      nodejs.symbol = " ";
      ocaml.symbol = " ";

      os.symbols = {
        Alpaquita = " ";
        Alpine = " ";
        AlmaLinux = " ";
        Amazon = " ";
        Android = " ";
        Arch = " ";
        Artix = " ";
        CachyOS = " ";
        CentOS = " ";
        Debian = " ";
        DragonFly = " ";
        Emscripten = " ";
        EndeavourOS = " ";
        Fedora = " ";
        FreeBSD = " ";
        Garuda = "󰛓 ";
        Gentoo = " ";
        HardenedBSD = "󰞌 ";
        Illumos = "󰈸 ";
        Kali = " ";
        Linux = " ";
        Mabox = " ";
        Macos = " ";
        Manjaro = " ";
        Mariner = " ";
        MidnightBSD = " ";
        Mint = " ";
        NetBSD = " ";
        NixOS = " ";
        Nobara = " ";
        OpenBSD = "󰈺 ";
        openSUSE = " ";
        OracleLinux = "󰌷 ";
        Pop = " ";
        Raspbian = " ";
        Redhat = " ";
        RedHatEnterprise = " ";
        RockyLinux = " ";
        Redox = "󰀘 ";
        Solus = "󰠳 ";
        SUSE = " ";
        Ubuntu = " ";
        Unknown = " ";
        Void = " ";
        Windows = "󰍲 ";
      };

      package.symbol = "󰏗 ";
      perl.symbol = " ";
      php.symbol = " ";
      pijul_channel.symbol = " ";
      pixi.symbol = "󰏗 ";
      python.symbol = " ";
      rlang.symbol = "󰟔 ";
      ruby.symbol = " ";
      rust.symbol = " ";
      scala.symbol = " ";
      swift.symbol = " ";
      zig.symbol = " ";
      gradle.symbol = " ";
    };
  };
}

{
  config,
  pkgs,
  ...
}: {
  programs.starship = {
    enable = true;

    settings = {
      format = "$os$all";

      os = {
        disabled = false;
        format = "[$symbol]($style)";
        style = "bold #7ebae4";
      };

      username = {
        show_always = true;
        format = "[$user]($style)";
        style_user = "bold green";
      };

      hostname = {
        ssh_only = true;
        format = "[@$hostname]($style)";
        style = "bold yellow";
        ssh_symbol = " ";
      };

      directory = {
        truncation_length = 3;
        format = " in [$path]($style) ";
        style = "bold blue";
        read_only = "󰌾";
      };

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };

      gcloud = {
        disabled = true;
        symbol = "  ";
      };

      aws.symbol = " ";
      azure = {
        disabled = false;
        symbol = " ";
      };

      buf.symbol = " ";
      bun.symbol = " ";
      c.symbol = " ";

      cpp = {
        disabled = false;
        symbol = " ";
        detect_files = ["compile_commands.json"];
      };

      custom.make = {
        detect_files = ["Makefile" "makefile" "GNUmakefile"];
        command = "make --version | head -n1 | cut -d' ' -f3";
        symbol = " ";
        style = "bold #6d8086";
        format = "via [$symbol(v$output )]($style)";
      };

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

      os.symbols.NixOS = " ";

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

{...}: {
  flake.homeModules.kidskoding = {
    config,
    inputs,
    pkgs,
    ...
  }: let
    c = config.lib.stylix.colors;
    orange = "38;2;${c."base09-rgb-r"};${c."base09-rgb-g"};${c."base09-rgb-b"}";
    noctalia = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
    # nixosBlue = "38;2;82;119;195";
    # nixosBlueLight = "38;2;126;186;228";
  in {
    programs.fastfetch = {
      enable = true;

      settings = {
        logo = {
          type = "small";
          /*
             color = {
            "1" = nixosBlue;
            "2" = nixosBlueLight;
            "3" = nixosBlue;
            "4" = nixosBlueLight;
            "5" = nixosBlue;
            "6" = nixosBlueLight;
          };
          */
          padding = {
            top = 5;
            left = 2;
          };
        };

        display = {
          separator = " ";
          size.ndigits = 1;
          color.keys = "38;2;${c."base04-rgb-r"};${c."base04-rgb-g"};${c."base04-rgb-b"}";
        };

        modules = [
          {
            type = "custom";
            key = "╭───────────╮";
          }
          {
            type = "title";
            key = "│ {#31} user    {#keys}│";
            format = "{user-name}";
          }
          {
            type = "title";
            key = "│ {#32}󰇅 hname   {#keys}│";
            format = "{host-name}";
          }
          {
            type = "os";
            key = "│ {#33}{icon} distro  {#keys}│";
          }
          {
            type = "kernel";
            key = "│ {#34} kernel  {#keys}│";
          }
          {
            type = "packages";
            key = "│ {#35}󰏗 pkgs    {#keys}│";
          }
          {
            type = "wm";
            key = "│ {#36}󰖲 wm      {#keys}│";
          }
          {
            type = "custom";
            key = "│ {#${orange}} toolkit {#keys}│";
            format = "noctalia ${noctalia.version}";
          }
          {
            type = "custom";
            key = "│ {#31}󰏘 theme   {#keys}│";
            format = c.scheme;
          }
          {
            type = "custom";
            key = "│ {#32} font    {#keys}│";
            format = config.stylix.fonts.monospace.name;
          }
          {
            type = "terminal";
            key = "│ {#33} term    {#keys}│";
          }
          {
            type = "shell";
            key = "│ {#34} shell   {#keys}│";
          }
          {
            type = "host";
            key = "│ {#35} host    {#keys}│";
          }
          {
            type = "cpu";
            key = "│ {#36}󰍛 cpu     {#keys}│";
            format = "{name}";
          }
          {
            type = "gpu";
            key = "│ {#${orange}}󰍛 gpu     {#keys}│";
            format = "{1} {2}";
            hideType = "integrated";
          }
          {
            type = "memory";
            key = "│ {#31} memory  {#keys}│";
          }
          {
            type = "disk";
            key = "│ {#32}󰉉 disk    {#keys}│";
            folders = "/";
            format = "{size-used} / {size-total} ({size-percentage}) - {filesystem}";
          }
          {
            type = "custom";
            key = "├───────────┤";
          }
          {
            type = "custom";
            key = "│ {#39} colors  {#keys}│";
            format = "{#31}██{#32}██{#33}██{#34}██{#35}██{#36}██{#${orange}}██{#37}██{#}";
          }
          {
            type = "custom";
            key = "╰───────────╯";
          }
        ];
      };
    };
  };
}

{config, ...}: let
  nixosBlue = "38;2;82;119;195";
  nixosBlueLight = "38;2;126;186;228";
in {
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        type = "small";
        color = {
          "1" = nixosBlue;
          "2" = nixosBlueLight;
          "3" = nixosBlue;
          "4" = nixosBlueLight;
          "5" = nixosBlue;
          "6" = nixosBlueLight;
        };
        padding = {
          top = 5;
          left = 3;
        };
      };

      display = {
        separator = " ";
        color.keys = "38;2;${config.theme.ansi.gray}";
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
          key = "│ {#31} toolkit {#keys}│";
          format = "noctalia ${config.programs.noctalia-shell.package.version}";
        }
        {
          type = "custom";
          key = "│ {#32}󰏘 theme   {#keys}│";
          format = config.theme.name;
        }
        {
          type = "custom";
          key = "│ {#33} font    {#keys}│";
          format = config.theme.fontFamily;
        }
        {
          type = "terminal";
          key = "│ {#34} term    {#keys}│";
        }
        {
          type = "shell";
          key = "│ {#35} shell   {#keys}│";
        }
        {
          type = "host";
          key = "│ {#36} host    {#keys}│";
        }
        {
          type = "cpu";
          key = "│ {#31}󰍛 cpu     {#keys}│";
          format = "{name}";
        }
        {
          type = "gpu";
          key = "│ {#32}󰍛 gpu     {#keys}│";
          format = "{1} {2}";
          hideType = "integrated";
        }
        {
          type = "memory";
          key = "│ {#33} memory  {#keys}│";
        }
        {
          type = "disk";
          key = "│ {#34}󰉉 disk    {#keys}│";
          folders = "/";
        }
        {
          type = "custom";
          key = "├───────────┤";
        }
        {
          type = "custom";
          key = "│ {#39} colors  {#keys}│";
          format = "{#31}██{#32}██{#33}██{#34}██{#35}██{#36}██{#37}██{#}";
        }
        {
          type = "custom";
          key = "╰───────────╯";
        }
      ];
    };
  };
}

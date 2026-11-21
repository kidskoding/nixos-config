{
  flake.homeModules.base = {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
      shellWrapperName = "y";

      settings = {
        mgr = {
          show_hidden = true;
          sort_by = "mtime";
          sort_dir_first = true;
        };
        preview = {
          max_width = 1000;
          max_height = 1000;
        };
      };
    };
  };
}

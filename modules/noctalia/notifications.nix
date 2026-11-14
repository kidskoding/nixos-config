{...}: {
  flake.homeModules.noctalia = {...}: {
    programs.noctalia.settings = {
      notification = {
        position = "top_right";
        scale = 0.85;
        width = 320;
        background_opacity = 1.0;
      };
    };
  };
}

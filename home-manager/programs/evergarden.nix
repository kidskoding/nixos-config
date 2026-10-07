{inputs, ...}: {
  imports = [inputs.evergarden.homeManagerModules.default];

  evergarden = {
    variant = "fall";
    accent = "green";

    ghostty.enable = true;
    fish.enable = true;
  };

  stylix.targets = {
    ghostty.colors.enable = false;
    fish.colors.enable = false;
  };
}

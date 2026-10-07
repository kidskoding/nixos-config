{
  inputs,
  osConfig,
  ...
}: {
  imports = [inputs.evergarden.homeManagerModules.default];

  evergarden = {
    inherit (osConfig.evergarden) variant accent;

    ghostty.enable = true;
    fish.enable = true;
  };

  home.sessionVariables = {
    EVERGARDEN_VARIANT = osConfig.evergarden.variant;
    EVERGARDEN_ACCENT = osConfig.evergarden.accent;
  };

  stylix.targets = {
    ghostty.colors.enable = false;
    fish.colors.enable = false;
  };
}

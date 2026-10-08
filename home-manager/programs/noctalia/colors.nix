{
  config,
  lib,
  inputs,
  osConfig,
  ...
}: let
  inherit (osConfig.evergarden) variant accent;
in {
  stylix.targets.noctalia.colors.enable = false;

  programs.noctalia = {
    customPalettes.evergarden = lib.importJSON "${inputs.evergarden-noctalia}/themes/evergarden-${variant}-${accent}.json";

    settings.theme = {
      mode = config.stylix.polarity;
      source = "custom";
      custom_palette = "evergarden";
    };
  };
}

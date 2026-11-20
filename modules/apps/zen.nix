{inputs, ...}: {
  flake.homeModules.desktop = {
    imports = [inputs.zen-browser.homeModules.beta];

    stylix.targets.zen-browser = {
      profileNames = ["default"];
      enableCss = false;
    };

    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      # Use the official catppuccin/zen-browser port.
      profiles.default = {
        name = "Default Profile";
        path = "cw0i5llc.Default Profile";
        isDefault = true;
        presets.catppuccin = {
          enable = true;
          flavor = "Macchiato";
          accent = "Mauve";
        };
      };

      policies.ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };

        "@react-devtools" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/react-devtools/latest.xpi";
          installation_mode = "force_installed";
        };

        "chrome2fox@neguiolidas.github.io" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/chrome2fox/latest.xpi";
          installation_mode = "force_installed";
        };

        "{203625b5-20fd-4b20-8bb5-76f07455d18b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/add-ons_google_chrome/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
}

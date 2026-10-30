{inputs, ...}: {
  flake.homeModules.desktop = {
    imports = [inputs.zen-browser.homeModules.beta];

    programs.zen-browser = {
      enable = true;

      policies.ExtensionSettings =
        builtins.mapAttrs (_: slug: {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${slug}/latest.xpi";
          installation_mode = "force_installed";
        }) {
          "uBlock0@raymondhill.net" = "ublock-origin";
          "@react-devtools" = "react-devtools";
          "chrome2fox@neguiolidas.github.io" = "chrome2fox";
          "{203625b5-20fd-4b20-8bb5-76f07455d18b}" = "add-ons_google_chrome";
        };
    };
  };
}

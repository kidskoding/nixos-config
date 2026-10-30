{
  inputs,
  self,
  ...
}: let
  overlays = [
    (final: prev: {
      libdisplay-info_0_2 = prev.libdisplay-info.overrideAttrs (old: rec {
        version = "0.2.0";
        src = prev.fetchFromGitLab {
          domain = "gitlab.freedesktop.org";
          owner = "emersion";
          repo = "libdisplay-info";
          rev = version;
          hash = "sha256-6xmWBrPHghjok43eIDGeshpUEQTuwWLXNHg7CnBUt3Q=";
        };
      });
    })

    inputs.niri.overlays.niri
  ];
in {
  flake.nixosModules.niri = {
    config,
    pkgs,
    ...
  }: {
    imports = [inputs.niri.nixosModules.niri];

    home-manager.sharedModules = [
      self.homeModules.niri
      {
        home.packages = with pkgs; [
          blueman
          hyprpicker
          nautilus
          networkmanagerapplet
          qimgv
        ];
      }
    ];

    # niri!!!
    nixpkgs.overlays = overlays;

    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
    niri-flake.cache.enable = false;

    systemd.packages = [config.programs.niri.package];

    # plasma (dolphin-style) file dialog for portal-using apps
    xdg.portal.extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
  };
}

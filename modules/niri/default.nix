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
    inputs,
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

  # niri + noctalia on a non-nixos host (victus on pop!_os)
  flake.homeModules.niriStandalone = {
    config,
    lib,
    pkgs,
    ...
  }: let
    niri = config.programs.niri.package;
    profile = config.home.profileDirectory;

    # greeters start sessions without a login shell, so load nix and home-manager first
    session = pkgs.writeShellScriptBin "niri-hm-session" ''
      for f in /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ${profile}/etc/profile.d/hm-session-vars.sh; do
        [ -e "$f" ] && . "$f"
      done
      exec ${lib.getExe' niri "niri-session"}
    '';
  in {
    imports = [
      inputs.niri.homeModules.niri
      inputs.niri.homeModules.stylix
      self.homeModules.niri
    ];

    nixpkgs.overlays = overlays;

    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };

    home.packages = [
      session
      self.packages.${pkgs.stdenv.hostPlatform.system}.noctalia
    ];

    # pop's systemd does not look in ~/.nix-profile for user units
    xdg.configFile = {
      "systemd/user/niri.service".source = "${niri}/lib/systemd/user/niri.service";
      "systemd/user/niri-shutdown.target".source = "${niri}/lib/systemd/user/niri-shutdown.target";

      # apt's xdg-desktop-portal only loads apt backends; pop ships gnome/gtk, not kde
      "xdg-desktop-portal/niri-portals.conf".text = lib.mkForce ''
        [preferred]
        default=gnome;gtk;
        org.freedesktop.impl.portal.Access=gtk;
        org.freedesktop.impl.portal.FileChooser=gnome;gtk;
        org.freedesktop.impl.portal.Notification=gtk;
        org.freedesktop.impl.portal.Secret=gnome-keyring;
      '';
    };

    # copied once into /usr/share/wayland-sessions so pop's login screen lists it
    xdg.dataFile."wayland-sessions/niri-hm.desktop".text = ''
      [Desktop Entry]
      Name=Niri
      Comment=niri from home-manager
      Exec=${profile}/bin/niri-hm-session
      Type=Application
      DesktopNames=niri
    '';

    services.polkit-gnome.enable = true;
  };
}

{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.umbriel = {pkgs, ...}: {
    imports = [inputs.umbriel.nixosModules.default];

    home-manager.sharedModules = [
      inputs.umbriel.homeModules.default
      self.homeModules.umbriel
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

    # umbriel!!!
    programs.umbriel.enable = true;

    fonts.enableDefaultPackages = true;
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    systemd.user.services.polkit-kde-agent = {
      description = "PolicyKit Authentication Agent";
      wantedBy = ["graphical-session.target"];
      after = ["graphical-session.target"];
      partOf = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

    # plasma (dolphin-style) file dialog for portal-using apps
    xdg.portal.extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      kdePackages.xdg-desktop-portal-kde
    ];
  };
}

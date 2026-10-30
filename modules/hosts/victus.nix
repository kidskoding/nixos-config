# cloned to ~/home-manager; apply with a bare `home-manager switch`, or `--flake .#popos`
{self, ...}: {
  # bare `home-manager switch` looks for user@hostname (set victus's hostname to popos)
  flake.homeConfigurations."kidskoding@popos" = self.homeConfigurations.popos;

  flake.homeConfigurations.popos = self.lib.mkHome {
    modules = [
      self.homeModules.gaming
      self.homeModules.niriStandalone
      {
        my = {
          flakeDir = "/home/kidskoding/home-manager";
          display = {
            width = 1920;
            height = 1080;
            refresh = 144.0;
            vrr = true;
            textScale = 1.25;
          };
        };

        # ghostty comes from its community .deb; home-manager will only write the config!
        programs.ghostty = {
          package = null;
          systemd.enable = false;
        };
      }
    ];
  };
}

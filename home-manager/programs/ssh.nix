{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        AddKeysToAgent = "yes";
        UserKnownHostsFile = "~/.ssh/known_hosts";
        ServerAliveInterval = 60;
      };

      "github.com" = {
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519";
        IdentitiesOnly = true;
      };

      "codeberg.org" = {
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519";
        IdentitiesOnly = true;
      };

      "ews" = {
        HostName = "linux.ews.illinois.edu";
        User = "ak123";
        IdentityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}

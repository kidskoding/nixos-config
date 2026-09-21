{
  imports = [
    ./alacritty
    ./fish.nix
    ./starship.nix
    ./zellij.nix
    ./fastfetch.nix

    ./niri
    ./noctalia
    ./thunderbird.nix
    ./obs.nix

    ./git.nix
    ./ssh.nix

    ./mangohud.nix
    ./tickrs.nix

    ./agents.nix
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}

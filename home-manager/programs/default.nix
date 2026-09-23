{
  config,
  inputs,
  ...
}: {
  imports = [
    ./ghostty
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

  # neovim config managed separately and is in its own repo (subtree)
  # linked live so edits do not need any rebuild
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixos/home-manager/programs/nvim";
}

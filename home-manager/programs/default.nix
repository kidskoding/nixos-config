{
  config,
  inputs,
  ...
}: {
  imports = [
    ./ghostty.nix
    ./fish.nix
    ./starship.nix
    ./zellij.nix
    ./fastfetch.nix

    ./niri
    ./noctalia
    ./obs.nix

    ./git.nix
    ./ssh.nix

    ./mangohud.nix
    ./tickrs.nix

    ./agents.nix

    ./evergarden.nix
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.neovide.enable = true;

  # neovim config managed separately and is in its own repo (subtree)
  # linked live so edits do not need any rebuild
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixos/home-manager/programs/nvim";
}

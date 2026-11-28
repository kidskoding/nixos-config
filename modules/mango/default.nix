{
  flake.nixosModules.mango = {
    programs.mango.enable = true;

    systemd.tmpfiles.rules = [
      "L+ /home/kidskoding/.config/mango - - - - /home/kidskoding/nixos/modules/mango"
    ];
  };
}

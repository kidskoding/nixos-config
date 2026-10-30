{
  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/nvme0n1";

    content = {
      type = "gpt";

      partitions = {
        ESP = {
          size = "1G";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [
              "fmask=0077"
              "dmask=0077"
            ];
          };
        };

        root = {
          size = "100%";
          content = {
            type = "btrfs";
            mountpoint = "/";
            subvolumes = {
              nix.mountpoint = "/nix";
              home.mountpoint = "/home";
            };
          };
        };

        swap = {
          size = "9G";
          content.type = "swap";
        };
      };
    };
  };
}

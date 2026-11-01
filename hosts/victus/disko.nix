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
          device = "/dev/disk/by-uuid/7399-B7C2";
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
          device = "/dev/disk/by-uuid/cd41f1e2-a2a0-4b92-baee-147c70dd5ca4";
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
          device = "/dev/disk/by-uuid/94effb1e-623d-4aa6-9398-454df9d2db46";
          content.type = "swap";
        };
      };
    };
  };
}

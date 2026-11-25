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
          device = "/dev/disk/by-uuid/63EB-E76A";
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
          end = "-41.9G";
          device = "/dev/disk/by-uuid/359bdb16-b294-4800-893d-40945d8ba7cd";
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
          size = "100%";
          device = "/dev/disk/by-uuid/26a2e3ed-d31e-4f34-8689-5762ec2f673b";
          content.type = "swap";
        };
      };
    };
  };
}

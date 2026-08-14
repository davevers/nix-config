{ den, inputs, ... }:
{
  den.aspects.virmire =
    { host, ... }:
    {
      nixos = {
        imports = [
          inputs.disko.nixosModules.disko
        ];
        disko.devices = {
          disk = {
            main = {
              type = "disk";
              device = "/dev/disk/by-id/virtio-01f456d8d5184891a4b9";
              content = {
                type = "gpt";
                partitions = {
                  bios = {
                    size = "1M";
                    type = "EF02";
                  };
                  root = {
                    size = "100%";
                    content = {
                      type = "btrfs";
                      extraArgs = [ "-f" ]; # Override existing partition
                      # Subvolumes must set a mountpoint in order to be mounted,
                      # unless their parent is mounted
                      subvolumes = {
                        # Subvolume name is different from mountpoint
                        "@" = {
                          mountpoint = "/";
                          mountOptions = [
                            "compress=zstd"
                            "noatime"
                          ];
                        };
                        "@nix" = {
                          mountpoint = "/nix";
                          mountOptions = [
                            "compress=zstd"
                            "noatime"
                          ];
                        };
                        "@appdata" = {
                          mountpoint = "/var/lib/homelab";
                          mountOptions = [
                            "compress=zstd"
                            "noatime"
                          ];
                        };
                        "@containers" = {
                          mountpoint = "/var/lib/containers";
                          mountOptions = [
                            "compress=zstd"
                            "noatime"
                          ];
                        };
                        "@cache" = {
                          mountpoint = "/var/cache";
                          mountOptions = [
                            "compress=zstd"
                            "noatime"
                          ];
                        };
                        "@snapshots" = {
                          mountpoint = "/.snapshots";
                          mountOptions = [
                            "compress=zstd"
                            "noatime"
                          ];
                        };
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
}

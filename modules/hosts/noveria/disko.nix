{ den, inputs, ... }:
{
  den.aspects.noveria =
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
              device = "/dev/disk/by-id/nvme-Lexar_SSD_NM620_1TB_QBB492R015480P1125";
              content = {
                type = "gpt";
                partitions = {
                  ESP = {
                    priority = 1;
                    name = "ESP";
                    size = "1G";
                    type = "EF00";
                    content = {
                      type = "filesystem";
                      format = "vfat";
                      mountpoint = "/boot";
                      mountOptions = [ "umask=0077" ];
                    };
                  };
                  swap = {
                    size = "8G";
                    content = {
                      type = "swap";
                      resumeDevice = false;
                    };
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
                        "@postgres" = {
                          mountpoint = "/var/lib/postgresql";
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

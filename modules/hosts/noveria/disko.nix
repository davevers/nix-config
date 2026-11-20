{
  den,
  inputs,
  lib,
  ...
}:
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
                      subvolumes =
                        lib.mapAttrs
                          (_: mountpoint: {
                            inherit mountpoint;
                            mountOptions = [
                              "compress=zstd"
                              "noatime"
                            ];
                          })
                          {
                            "@" = "/";
                            "@nix" = "/nix";
                            "@appdata" = "/var/lib/homelab";
                            "@postgres" = "/var/lib/postgresql";
                            "@containers" = "/var/lib/containers";
                            "@cache" = "/var/cache";
                            "@snapshots" = "/.snapshots";
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

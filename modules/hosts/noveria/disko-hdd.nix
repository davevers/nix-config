{ den, inputs, ... }:
{
  den.aspects.hdd-provision =
    { host, ... }:
    {
      nixos = {
        imports = [
          inputs.disko.nixosModules.disko
        ];
        disko.devices = {
          disk = {
            data1 = {
              type = "disk";
              device = "/dev/disk/by-id/ata-ST8000NM0045-1RL112_ZA159V83";
              content = {
                type = "gpt";
                partitions = {
                  crypt_p1 = {
                    size = "100%";
                    content = {
                      type = "luks";
                      name = "p1";
                      initrdUnlock = false;
                    };
                  };
                };
              };
            };

            data2 = {
              type = "disk";
              device = "/dev/disk/by-id/ata-ST8000NM0045-1RL112_ZA158CRD";
              content = {
                type = "gpt";
                partitions = {
                  crypt_p2 = {
                    size = "100%";
                    content = {
                      type = "luks";
                      name = "p2";
                      initrdUnlock = false;
                      content = {
                        type = "btrfs";
                        extraArgs = [
                          "-f"
                          "-d"
                          "raid1"
                          "-m"
                          "raid1"
                          "/dev/mapper/p1"
                        ];

                        subvolumes = {
                          "@photos" = {
                            mountpoint = "/mnt/storage/photos";
                            mountOptions = [
                              "noauto"
                              "nofail"
                              "compress=zstd"
                              "noatime"
                            ];
                          };

                          "@media" = {
                            mountpoint = "/mnt/storage/media";
                            mountOptions = [
                              "noauto"
                              "nofail"
                              "compress=zstd"
                              "noatime"
                            ];
                          };

                          "@documents" = {
                            mountpoint = "/mnt/storage/documents";
                            mountOptions = [
                              "noauto"
                              "nofail"
                              "compress=zstd"
                              "noatime"
                            ];
                          };

                          "@backups" = {
                            mountpoint = "/mnt/storage/backups";
                            mountOptions = [
                              "noauto"
                              "nofail"
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
    };
}

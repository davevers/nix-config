{
  den,
  inputs,
  lib,
  ...
}:
let
  layout = import ./_storage-layout.nix;
in
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
              device = layout.disks.data1.device;
              content = {
                type = "gpt";
                partitions = {
                  "crypt_${layout.disks.data1.mapperName}" = {
                    size = "100%";
                    content = {
                      type = "luks";
                      name = layout.disks.data1.mapperName;
                      initrdUnlock = false;
                    };
                  };
                };
              };
            };

            data2 = {
              type = "disk";
              device = layout.disks.data2.device;
              content = {
                type = "gpt";
                partitions = {
                  "crypt_${layout.disks.data2.mapperName}" = {
                    size = "100%";
                    content = {
                      type = "luks";
                      name = layout.disks.data2.mapperName;
                      initrdUnlock = false;
                      content = {
                        type = "btrfs";
                        extraArgs = [
                          "-f"
                          "-d"
                          "raid1"
                          "-m"
                          "raid1"
                          layout.primaryMapperDevice
                        ];

                        subvolumes = builtins.listToAttrs (
                          map (
                            volume:
                            lib.nameValuePair volume.subvolume {
                              inherit (volume) mountpoint;
                              inherit (layout) mountOptions;
                            }
                          ) layout.volumes
                        );
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

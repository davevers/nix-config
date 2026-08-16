{
  den,
  lib,
  ...
}:
{
  den.hosts.x86_64-linux.noveria.users.dave = {
  };
  den.aspects.noveria = {
    includes = [
      den.aspects.server
      den.aspects.smart
      # den.aspects.hdd-provision
    ];

    nixos = { pkgs, ... }: {
      imports = [
        ./_hardware-configuration.nix
      ];

      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
          systemd-boot.configurationLimit = 10;
        };
      };

      fileSystems."/mnt/storage/photos" = {
          device = "/dev/mapper/p1";
          fsType = "btrfs";
          options = [
            "noauto"
            "nofail"
            "compress=zstd"
            "noatime"
            "subvol=@photos"
          ];
        };

        fileSystems."/mnt/storage/media" = {
          device = "/dev/mapper/p1";
          fsType = "btrfs";
          options = [
            "noauto"
            "nofail"
            "compress=zstd"
            "noatime"
            "subvol=@media"
          ];
        };

        fileSystems."/mnt/storage/documents" = {
          device = "/dev/mapper/p1";
          fsType = "btrfs";
          options = [
            "noauto"
            "nofail"
            "compress=zstd"
            "noatime"
            "subvol=@documents"
          ];
        };

        fileSystems."/mnt/storage/backups" = {
          device = "/dev/mapper/p1";
          fsType = "btrfs";
          options = [
            "noauto"
            "nofail"
            "compress=zstd"
            "noatime"
            "subvol=@backups"
          ];
        };

      networking.hostName = "noveria";
      system.stateVersion = lib.mkDefault "26.05";
      # security.sudo.wheelNeedsPassword = false;

      networking.nftables.enable = true;

      networking.firewall = {
        enable = true;

        # Do not globally open 80/443 here.
        allowedTCPPorts = [
          22
          88
          443
        ];
      };

      environment.systemPackages = with pkgs; [
        cryptsetup
        btrfs-progs
      ];
    };
  };
}

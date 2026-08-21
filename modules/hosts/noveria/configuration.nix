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
      den.aspects.arr
      den.aspects.jellyfin
      den.aspects.seerr
      den.aspects.server
      den.aspects.smart
      # den.aspects.hdd-provision
    ];

    nixos =
      { pkgs, ... }:
      let
        mediaStorageUnlock = pkgs.writeShellApplication {
          name = "media-storage-unlock";
          runtimeInputs = with pkgs; [
            cryptsetup
            systemd
            util-linux
          ];
          text = ''
            if (( EUID != 0 )); then
              echo "Run this command as root (for example: sudo media-storage-unlock)." >&2
              exit 1
            fi

            device_paths=(
              "/dev/disk/by-id/ata-ST8000NM0045-1RL112_ZA159V83-part1"
              "/dev/disk/by-id/ata-ST8000NM0045-1RL112_ZA158CRD-part1"
            )
            mapper_names=(p1 p2)
            locked_indexes=()

            for index in "''${!mapper_names[@]}"; do
              if cryptsetup status "''${mapper_names[$index]}" >/dev/null 2>&1; then
                echo "''${mapper_names[$index]} is already unlocked."
              else
                locked_indexes+=("$index")
              fi
            done

            if (( ''${#locked_indexes[@]} > 0 )); then
              if [[ ! -r /dev/tty || ! -w /dev/tty ]]; then
                echo "A TTY is required for the passphrase prompt; connect with ssh -t." >&2
                exit 1
              fi

              IFS= read -r -s -p "Media storage passphrase: " passphrase </dev/tty
              echo >/dev/tty
              trap 'unset passphrase' EXIT

              if [[ -z "$passphrase" ]]; then
                echo "The passphrase cannot be empty." >&2
                exit 1
              fi

              for index in "''${locked_indexes[@]}"; do
                echo "Unlocking ''${mapper_names[$index]}..."
                if ! printf '%s' "$passphrase" \
                  | cryptsetup open --key-file=- \
                    "''${device_paths[$index]}" "''${mapper_names[$index]}"; then
                  echo "Failed to unlock ''${mapper_names[$index]}; storage was not mounted." >&2
                  exit 1
                fi
              done

              unset passphrase
              trap - EXIT
            fi

            echo "Starting the media storage mount and application stack..."
            systemctl start mnt-storage-media.mount

            if ! findmnt --mountpoint /mnt/storage/media >/dev/null; then
              echo "/mnt/storage/media is not mounted." >&2
              exit 1
            fi

            findmnt --mountpoint /mnt/storage/media --output TARGET,SOURCE,FSTYPE,OPTIONS
            systemctl is-active --quiet arr-media.target
            echo "Media storage is mounted and arr-media.target is active."
          '';
        };
      in
      {
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

        hardware.graphics = {
          enable = true;
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
          allowedTCPPorts = [ ];
          extraInputRules = ''
            ip saddr 192.168.1.1/24 tcp dport {
              80,    # HTTP
              443,   # HTTPS
            } accept
          '';
        };

        environment.systemPackages = with pkgs; [
          cryptsetup
          btrfs-progs
          mediaStorageUnlock
        ];
      };
  };
}

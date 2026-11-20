{
  den.aspects.noveria.nixos =
    {
      lib,
      pkgs,
      utils,
      ...
    }:
    let
      layout = import ./_storage-layout.nix;
      disks = builtins.attrValues layout.disks;
      partitionPaths = map (disk: "${disk.device}-part1") disks;
      mapperNames = map (disk: disk.mapperName) disks;
      applicationVolumes = builtins.filter (volume: volume ? target) layout.volumes;
      mountpoints = map (volume: volume.mountpoint) applicationVolumes;
      mountUnits = map (path: "${utils.escapeSystemdPath path}.mount") mountpoints;
      targets = map (volume: volume.target) applicationVolumes;

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

          device_paths=(${lib.escapeShellArgs partitionPaths})
          mapper_names=(${lib.escapeShellArgs mapperNames})
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

          echo "Starting the media, photo and document storage mounts and application stacks..."
          systemctl start ${lib.escapeShellArgs mountUnits}

          for mountpoint in ${lib.escapeShellArgs mountpoints}; do
            if ! findmnt --mountpoint "$mountpoint" >/dev/null; then
              echo "$mountpoint is not mounted." >&2
              exit 1
            fi

            findmnt --mountpoint "$mountpoint" --output TARGET,SOURCE,FSTYPE,OPTIONS
          done

          systemctl start ${lib.escapeShellArgs targets}
          for target in ${lib.escapeShellArgs targets}; do
            systemctl is-active --quiet "$target"
          done
          echo "Media, photo and document storage are mounted; ${lib.concatStringsSep ", " targets} are active."
        '';
      };
    in
    {
      fileSystems = builtins.listToAttrs (
        map (
          volume:
          lib.nameValuePair volume.mountpoint {
            device = layout.primaryMapperDevice;
            fsType = "btrfs";
            options = layout.mountOptions ++ [ "subvol=${volume.subvolume}" ];
          }
        ) layout.volumes
      );

      environment.systemPackages = with pkgs; [
        cryptsetup
        btrfs-progs
        mediaStorageUnlock
      ];
    };
}

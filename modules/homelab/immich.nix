{ den, lib, ... }:
{
  den.aspects.immich = {
    nixos =
      { pkgs, config, ... }:
      let
        photosRoot = "/mnt/storage/photos";
        photosMount = "mnt-storage-photos.mount";
        photosTarget = "immich-photos.target";
      in
      {
        users.users.immich.extraGroups = [
          "render"
        ];

        services.immich = {
          enable = true;
          host = "127.0.0.1";
          mediaLocation = photosRoot;
          settings = {
            oauth = {
              enabled = true;
              clientId._secret = config.sops.secrets."immich/oauth/client-id".path;
              clientSecret._secret = config.sops.secrets."immich/oauth/client-secret".path;
              issuerUrl = "https://auth.td-home.xyz";
            };
            server.externalDomain = "https://photos.td-home.xyz";
          };
          accelerationDevices = [
            "/dev/dri/renderD128"
          ];
        };

        systemd.targets.immich-photos = {
          description = "Storage-backed Immich photo stack";
          upheldBy = [ photosMount ];
          requires = [ "immich-photos-layout.service" ];
          bindsTo = [ photosMount ];
          after = [
            photosMount
            "immich-photos-layout.service"
          ];
        };

        systemd.services = {
          immich-photos-layout = {
            description = "Prepare the Immich photo storage directory";
            requires = [ photosMount ];
            after = [ photosMount ];
            unitConfig.RequiresMountsFor = [ photosRoot ];
            serviceConfig = {
              Type = "oneshot";
              RemainAfterExit = true;
            };
            script = ''
              if ! ${pkgs.util-linux}/bin/findmnt --mountpoint ${lib.escapeShellArg photosRoot} >/dev/null; then
                echo "${photosRoot} is not a mounted filesystem; refusing to prepare Immich storage." >&2
                exit 1
              fi

              filesystem_type="$(${pkgs.util-linux}/bin/findmnt --noheadings --output FSTYPE --target ${lib.escapeShellArg photosRoot})"
              if [[ "$filesystem_type" != "btrfs" ]]; then
                echo "Expected ${photosRoot} to be btrfs, found $filesystem_type." >&2
                exit 1
              fi

              install -d -m 0700 -o immich -g immich ${lib.escapeShellArg photosRoot}
            '';
          };

          immich-server = {
            wantedBy = lib.mkForce [ ];
            upheldBy = [ photosTarget ];
            partOf = [ photosTarget ];
            requires = [ "immich-photos-layout.service" ];
            after = [ "immich-photos-layout.service" ];
            unitConfig.RequiresMountsFor = [
              photosRoot
              "/var/lib/homelab/immich"
            ];
            serviceConfig.StateDirectory = lib.mkForce "homelab/immich";
          };

          immich-machine-learning = {
            wantedBy = lib.mkForce [ ];
            upheldBy = [ photosTarget ];
            partOf = [ photosTarget ];
            requires = [ "immich-photos-layout.service" ];
            after = [ "immich-photos-layout.service" ];
            unitConfig.RequiresMountsFor = [ photosRoot ];
          };
        };

        services.caddy.virtualHosts."photos.td-home.xyz".extraConfig = ''
          reverse_proxy 127.0.0.1:2283
        '';

        sops.secrets = {
          "immich/oauth/client-id" = {
            owner = "immich";
          };
          "immich/oauth/client-secret" = {
            owner = "immich";
          };
        };
      };
  };
}

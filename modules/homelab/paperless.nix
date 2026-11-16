{ den, lib, ... }:
{
  den.aspects.paperless = {
    nixos =
      { config, pkgs, ... }:
      let
        documentsRoot = "/mnt/storage/documents";
        documentsMount = "mnt-storage-documents.mount";
        documentsTarget = "paperless-documents.target";
        paperlessRoot = "${documentsRoot}/paperless";
        cfg = config.services.paperless;
      in
      {
        services.paperless = {
          enable = true;
          # Temporary workaround: pinned nixpkgs supplies Torch 2.15, while
          # Paperless 3.4.2 declares <2.15. Keep dependency checks and tests enabled.
          package = pkgs.paperless-ngx.overrideAttrs (old: {
            pythonRelaxDeps = (old.pythonRelaxDeps or [ ]) ++ [ "torch" ];
          });
          address = "127.0.0.1";
          port = 28981;
          dataDir = "${paperlessRoot}/data";
          mediaDir = "${paperlessRoot}/media";
          consumptionDir = "${paperlessRoot}/consume";
          environmentFile = config.sops.templates."paperless-env".path;
          settings = {
            PAPERLESS_URL = "https://docs.td-home.xyz";
            PAPERLESS_OCR_LANGUAGE = "nld+eng";
            PAPERLESS_APPS = "allauth.socialaccount.providers.openid_connect";
            # Keep local login available while testing Pocket ID.
            PAPERLESS_DISABLE_REGULAR_LOGIN = false;
          };
          # Avoid rebuilding the OCR dependencies for a reduced language set.
          tesseractLanguages = null;
        };

        sops.secrets = {
          "paperless/oauth/client-id".owner = cfg.user;
          "paperless/oauth/client-secret".owner = cfg.user;
        };

        sops.templates."paperless-env" = {
          owner = cfg.user;
          group = cfg.group;
          mode = "0400";
          restartUnits = [
            "paperless-scheduler.service"
            "paperless-consumer.service"
            "paperless-task-queue.service"
            "paperless-web.service"
          ];
          content = ''
            PAPERLESS_SOCIALACCOUNT_PROVIDERS='${
              builtins.toJSON {
                openid_connect = {
                  OAUTH_PKCE_ENABLED = true;
                  SCOPE = [
                    "openid"
                    "profile"
                    "email"
                  ];
                  APPS = [
                    {
                      provider_id = "pocket-id";
                      name = "Pocket ID";
                      client_id = config.sops.placeholder."paperless/oauth/client-id";
                      secret = config.sops.placeholder."paperless/oauth/client-secret";
                      settings.server_url = "https://auth.td-home.xyz/.well-known/openid-configuration";
                    }
                  ];
                };
              }
            }'
          '';
        };

        # Keep queued document metadata on the encrypted filesystem too.
        services.redis.servers.paperless.settings.dir = lib.mkForce "${paperlessRoot}/redis";

        # The layout service creates these only after the filesystem is mounted.
        systemd.tmpfiles.settings."10-paperless" = lib.mkForce { };

        systemd.targets.paperless-documents = {
          description = "Storage-backed Paperless document stack";
          upheldBy = [ documentsMount ];
          requires = [ "paperless-documents-layout.service" ];
          bindsTo = [ documentsMount ];
          after = [
            documentsMount
            "paperless-documents-layout.service"
          ];
        };

        systemd.services = lib.mkMerge [
          (lib.genAttrs
            [
              "paperless-secret-key"
              "paperless-scheduler"
              "paperless-consumer"
              "paperless-task-queue"
              "paperless-web"
              "redis-paperless"
            ]
            (_: {
              wantedBy = lib.mkForce [ ];
              upheldBy = [ documentsTarget ];
              partOf = [ documentsTarget ];
              requires = [ "paperless-documents-layout.service" ];
              after = [ "paperless-documents-layout.service" ];
              unitConfig.RequiresMountsFor = [ documentsRoot ];
            })
          )
          {
            paperless-documents-layout = {
              description = "Prepare the Paperless document storage directories";
              requires = [ documentsMount ];
              bindsTo = [ documentsMount ];
              after = [ documentsMount ];
              unitConfig.RequiresMountsFor = [ documentsRoot ];
              serviceConfig = {
                Type = "oneshot";
                RemainAfterExit = true;
              };
              script = ''
                if ! ${pkgs.util-linux}/bin/findmnt --mountpoint ${lib.escapeShellArg documentsRoot} >/dev/null; then
                  echo "${documentsRoot} is not a mounted filesystem; refusing to prepare Paperless storage." >&2
                  exit 1
                fi

                filesystem_type="$(${pkgs.util-linux}/bin/findmnt --noheadings --output FSTYPE --target ${lib.escapeShellArg documentsRoot})"
                if [[ "$filesystem_type" != "btrfs" ]]; then
                  echo "Expected ${documentsRoot} to be btrfs, found $filesystem_type." >&2
                  exit 1
                fi

                install -d -m 0710 -o ${cfg.user} -g redis-paperless ${lib.escapeShellArg paperlessRoot}
                install -d -m 0700 -o ${cfg.user} -g ${cfg.group} ${
                  lib.escapeShellArgs [
                    cfg.dataDir
                    "${cfg.dataDir}/index"
                    cfg.mediaDir
                    cfg.consumptionDir
                  ]
                }
                install -d -m 0700 -o redis-paperless -g redis-paperless ${lib.escapeShellArg "${paperlessRoot}/redis"}
              '';
            };

            redis-paperless.serviceConfig.ReadWritePaths = [ "${paperlessRoot}/redis" ];
          }
        ];

        services.caddy.virtualHosts."docs.td-home.xyz".extraConfig = ''
          reverse_proxy 127.0.0.1:28981
        '';
      };
  };
}

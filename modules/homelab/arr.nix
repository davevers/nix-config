{
  den,
  lib,
  ...
}:
{
  den.aspects.arr = {
    includes = [
      (den.batteries.unfree [
        "unrar"
      ])
    ];
    nixos =
      { config, pkgs, ... }:
      let
        mediaRoot = "/mnt/storage/media";
        mediaMount = "mnt-storage-media.mount";
        mediaTarget = "arr-media.target";
        mediaDirectories = map (path: "${mediaRoot}/${path}") [
          "usenet"
          "usenet/incomplete"
          "usenet/complete"
          "usenet/complete/tv"
          "usenet/complete/movies"
          "library"
          "library/tv"
          "library/movies"
        ];
      in
      {
        users.groups.media = { };
        users.users.sonarr.extraGroups = [ "media" ];
        users.users.radarr.extraGroups = [ "media" ];
        users.users.sabnzbd.extraGroups = [ "media" ];

        systemd.tmpfiles.settings."10-prowlarr"."/var/lib/homelab/prowlarr".d = {
          user = lib.mkForce "-";
          group = lib.mkForce "-";
          mode = lib.mkForce "0700";
        };

        services.prowlarr = {
          enable = true;
          dataDir = "/var/lib/homelab/prowlarr";
          settings.server = {
            bindaddress = "127.0.0.1";
            port = 9696;
          };
        };

        services.sonarr = {
          enable = true;
          group = "media";
          dataDir = "/var/lib/homelab/sonarr";
          settings.server = {
            bindaddress = "127.0.0.1";
            port = 8989;
          };
        };

        services.radarr = {
          enable = true;
          group = "media";
          dataDir = "/var/lib/homelab/radarr";
          settings.server = {
            bindaddress = "127.0.0.1";
            port = 7878;
          };
        };

        services.recyclarr = {
          enable = true;
          configuration = {
            sonarr = {
              sonarr-main = {
                api_key = {
                  _secret = config.sops.secrets."sonarr/api-key".path;
                };
                base_url = "http://localhost:8989";
                delete_old_custom_formats = true;
                quality_definition = {
                  type = "series";
                };
                quality_profiles = [
                  {
                    # WEB-1080p
                    trash_id = "72dae194fc92bf828f32cde7744e51a1";
                    reset_unmatched_scores.enabled = true;
                  }
                  {
                    # WEB-2160p
                    trash_id = "d1498e7d189fbe6c7110ceaabb7473e6";
                    reset_unmatched_scores.enabled = true;
                  }
                ];
              };
            };
            radarr = {
              radarr-main = {
                api_key = {
                  _secret = config.sops.secrets."radarr/api-key".path;
                };
                base_url = "http://localhost:7878";
                delete_old_custom_formats = true;
                quality_definition = {
                  type = "movie";
                };
                quality_profiles = [
                  {
                    # WEB-1080p
                    trash_id = "e8c5acb741363a0dbda67d3978f4912f";
                    reset_unmatched_scores.enabled = true;
                  }
                  {
                    # WEB-2160p
                    trash_id = "0537bd27bcf8da604f30a862343b1742";
                    reset_unmatched_scores.enabled = true;
                  }
                ];
              };
            };
          };
        };

        services.sabnzbd = {
          enable = true;
          group = "media";
          stateDir = "homelab/sabnzbd";
          configFile = null;
          # allowConfigWrite = true;
          secretValues = {
            "@eweka_username@" = config.sops.secrets."sabnzbd/eweka/username".path;
            "@eweka_password@" = config.sops.secrets."sabnzbd/eweka/password".path;
            "@api_key@" = config.sops.secrets."sabnzbd/api-key".path;
            "@nzb_key@" = config.sops.secrets."sabnzbd/nzb-key".path;
          };
          settings = {
            misc = {
              host = "127.0.0.1";
              port = 8080;
              local_ranges = "100.64.0.0/10";
              inet_exposure = 0;
              download_dir = "${mediaRoot}/usenet/incomplete";
              complete_dir = "${mediaRoot}/usenet/complete";
              host_whitelist = "downloads.td-home.xyz";
              permissions = "775";
              nzb_key = "@nzb_key@";
              api_key = "@api_key@";
            };
            servers.eweka = {
              name = "Eweka";
              displayname = "Eweka";
              host = "news.eweka.nl";
              port = 563;
              ssl = true;
              username = "@eweka_username@";
              password = "@eweka_password@";
            };
            categories = {
              tv = {
                name = "tv";
                dir = "tv";
                priority = 0;
                pp = 3;
              };
              movies = {
                name = "movies";
                dir = "movies";
                priority = 0;
                pp = 3;
              };
            };
          };
        };

        sops.secrets = {
          "sabnzbd/eweka/username" = {
            owner = "sabnzbd";
          };

          "sabnzbd/eweka/password" = {
            owner = "sabnzbd";
          };

          "sabnzbd/nzb-key" = {
            owner = "sabnzbd";
          };
          "sabnzbd/api-key" = {
            owner = "sabnzbd";
          };
          "sonarr/api-key" = {
            owner = "recyclarr";
          };
          "radarr/api-key" = {
            owner = "recyclarr";
          };
        };

        systemd.targets.arr-media = {
          description = "Storage-backed ARR and media application stack";
          # Unlike WantedBy, Upholds also brings the target back after a
          # changed layout unit temporarily stops it during a NixOS switch.
          upheldBy = [ mediaMount ];
          requires = [ "arr-media-layout.service" ];
          bindsTo = [ mediaMount ];
          after = [
            mediaMount
            "arr-media-layout.service"
          ];
        };

        systemd.services = {
          arr-media-layout = {
            description = "Create the ARR media directory layout";
            requires = [ mediaMount ];
            after = [ mediaMount ];
            unitConfig.RequiresMountsFor = [ mediaRoot ];
            serviceConfig = {
              Type = "oneshot";
              RemainAfterExit = true;
            };
            script = ''
              if ! ${pkgs.util-linux}/bin/findmnt --mountpoint ${lib.escapeShellArg mediaRoot} >/dev/null; then
                echo "${mediaRoot} is not a mounted filesystem; refusing to create media directories." >&2
                exit 1
              fi

              filesystem_type="$(${pkgs.util-linux}/bin/findmnt --noheadings --output FSTYPE --target ${lib.escapeShellArg mediaRoot})"
              if [[ "$filesystem_type" != "btrfs" ]]; then
                echo "Expected ${mediaRoot} to be btrfs, found $filesystem_type." >&2
                exit 1
              fi

              install -d -m 2775 -o root -g media ${lib.escapeShellArgs mediaDirectories}
            '';
          };

          prowlarr = {
            wantedBy = lib.mkForce [ ];
            upheldBy = [ mediaTarget ];
            partOf = [ mediaTarget ];
            requires = [ "arr-media-layout.service" ];
            after = [ "arr-media-layout.service" ];
            unitConfig.RequiresMountsFor = [ mediaRoot ];
          };

          sonarr = {
            wantedBy = lib.mkForce [ ];
            upheldBy = [ mediaTarget ];
            partOf = [ mediaTarget ];
            requires = [ "arr-media-layout.service" ];
            after = [ "arr-media-layout.service" ];
            unitConfig.RequiresMountsFor = [ mediaRoot ];
            serviceConfig.UMask = lib.mkForce "0002";
          };

          radarr = {
            wantedBy = lib.mkForce [ ];
            upheldBy = [ mediaTarget ];
            partOf = [ mediaTarget ];
            requires = [ "arr-media-layout.service" ];
            after = [ "arr-media-layout.service" ];
            unitConfig.RequiresMountsFor = [ mediaRoot ];
            serviceConfig.UMask = lib.mkForce "0002";
          };

          sabnzbd = {
            wantedBy = lib.mkForce [ ];
            upheldBy = [ mediaTarget ];
            partOf = [ mediaTarget ];
            requires = [ "arr-media-layout.service" ];
            after = [ "arr-media-layout.service" ];
            unitConfig.RequiresMountsFor = [ mediaRoot ];
            serviceConfig.UMask = "0002";
          };

          recyclarr = {
            partOf = [ mediaTarget ];
            requires = [
              "sonarr.service"
              "radarr.service"
            ];
            after = [
              "sonarr.service"
              "radarr.service"
            ];
          };
        };

        systemd.timers.recyclarr = {
          wantedBy = lib.mkForce [ ];
          upheldBy = [ mediaTarget ];
          partOf = [ mediaTarget ];
          after = [
            "sonarr.service"
            "radarr.service"
          ];
        };

        services.caddy.virtualHosts = {
          "prowlarr.td-home.xyz".extraConfig = ''
            reverse_proxy 127.0.0.1:9696
          '';

          "sonarr.td-home.xyz".extraConfig = ''
            reverse_proxy 127.0.0.1:8989
          '';

          "radarr.td-home.xyz".extraConfig = ''
            reverse_proxy 127.0.0.1:7878
          '';

          "discover.td-home.xyz".extraConfig = ''
            reverse_proxy 127.0.0.1:5055
          '';

          "downloads.td-home.xyz".extraConfig = ''
            reverse_proxy 127.0.0.1:8080
          '';
        };
      };
  };
}

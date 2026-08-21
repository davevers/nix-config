{ den, lib, ... }: {
  den.aspects.jellyfin = {
    nixos = {

      users.users.jellyfin.extraGroups = [
        "media"
        "render"
        "video"
      ];

      services.jellyfin = {
        enable = true;
        dataDir = "/var/lib/homelab/jellyfin";
        hardwareAcceleration = {
          enable = true;
          type = "qsv";
          device = "/dev/dri/renderD128";
        };
        forceEncodingConfig = true;
        transcoding = {
          hardwareDecodingCodecs = {
            h264 = true;
            hevc = true;
            hevc10bit = true;
            mpeg2 = true;
            vc1 = true;
            vp8 = true;
            vp9 = true;
          };
          enableHardwareEncoding = true;
          hardwareEncodingCodecs = {
            hevc = true;
          };
          throttleTranscoding = true;
        };
      };

      systemd.services.jellyfin = {
        wantedBy = lib.mkForce [ ];
        upheldBy = [ "arr-media.target" ];
        partOf = [ "arr-media.target" ];
        requires = [ "arr-media-layout.service" ];
        after = [ "arr-media-layout.service" ];
        unitConfig.RequiresMountsFor = [ "/mnt/storage/media" ];
      };

      services.caddy.virtualHosts = {
        "video.td-home.xyz".extraConfig = ''
          reverse_proxy 127.0.0.1:8096
        '';
      };
    };
  };
}

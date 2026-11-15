{ den, lib, ... }: {
  den.aspects.seerr = {
    nixos = {
      services.seerr = {
        enable = true;
        configDir = "/var/lib/homelab/seerr";
      };

      services.caddy.virtualHosts."discover.td-home.xyz".extraConfig = ''
        reverse_proxy 127.0.0.1:5055
      '';

      systemd.services.seerr = {
        wantedBy = lib.mkForce [ ];
        upheldBy = [ "arr-media.target" ];
        partOf = [ "arr-media.target" ];
        requires = [ "arr-media-layout.service" ];
        after = [ "arr-media-layout.service" ];
        unitConfig.RequiresMountsFor = [ "/mnt/storage/media" ];
        serviceConfig = {
          StateDirectory = lib.mkForce "homelab/seerr";
        };
      };
    };
  };
}

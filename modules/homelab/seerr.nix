{ den, lib, ... }: {
  den.aspects.seerr = {
    nixos = {
      services.seerr = {
        enable = true;
        configDir = "/var/lib/homelab/seerr";
      };

      systemd.services.seerr = {
        wantedBy = lib.mkForce [ ];
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

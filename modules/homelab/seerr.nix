{ den, lib, ... }: {
  den.aspects.seerr = {
    nixos = {
      services.seerr = {
        enable = true;
        configDir = "/var/lib/homelab/seerr";
      };

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

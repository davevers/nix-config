{
  den.aspects.incus = {
    nixos = {
      networking.nftables.enable = true;
      networking.firewall.trustedInterfaces = [
        "incusbr0"
      ];
      virtualisation.incus = {
        enable = true;
        ui.enable = true;
        preseed = {
          networks = [
            {
              name = "incusbr0";
              type = "bridge";
              config = {
                "ipv4.address" = "10.0.100.1/24";
                "ipv4.nat" = "true";
                "ipv6.address" = "none";
              };
            }
          ];

          storage_pools = [
            {
              name = "default";
              driver = "dir";
              config = {
                source = "/var/lib/incus/storage-pools/default";
              };
            }
          ];

          profiles = [
            {
              name = "default";
              devices = {
                eth0 = {
                  type = "nic";
                  name = "eth0";
                  network = "incusbr0";
                };

                root = {
                  type = "disk";
                  path = "/";
                  pool = "default";
                  size = "25GiB";
                };
              };
            }
          ];
        };
      };
    };
  };
}

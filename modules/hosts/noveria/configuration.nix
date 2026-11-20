{ den, ... }:
{
  den.hosts.x86_64-linux.noveria.users.dave = {
  };
  den.aspects.noveria = {
    includes = [
      den.aspects.arr
      den.aspects.immich
      den.aspects.jellyfin
      den.aspects.miniflux
      den.aspects.paperless
      den.aspects.seerr
      den.aspects.server
      den.aspects.smart
      # den.aspects.hdd-provision
    ];

    nixos = {
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

      # Skip routine SMART checks while an ATA disk is in standby.
      services.smartd.defaults.autodetected = "-a -n standby";

      networking.hostName = "noveria";
      # Preserve the existing compatibility baseline; do not track nixpkgs.
      system.stateVersion = "25.11";
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
    };
  };
}

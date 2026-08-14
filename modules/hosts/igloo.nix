{ den, lib, ... }:
{

  den.hosts.x86_64-linux.loki.microvm.guests = [
    den.hosts.x86_64-linux.vps-test
  ];

  den.hosts.x86_64-linux.vps-test = {
    intoAttr = [ ]; # dont produce Guest nixosConfiguration at flake output
  };

  den.aspects.no-boot.nixos = {
    boot.loader.grub.enable = false;
    fileSystems."/".device = "/dev/null";
  };

  den.aspects.loki = {
    # USER TODO: remove this on real bootable server
    # includes = [ den.aspects.no-boot ];

    # NOTE: no microvm class exist for Host, only for Guests
    nixos.microvm.host.startupTimeout = 300;
  };

  den.aspects.vps-test = {
    # resulting nixos-module is set at server: microvm.vms.<name>.config
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.cowsay ];

        services.openssh = {
          enable = true;
          settings.PermitRootLogin = "yes";
          settings.PasswordAuthentication = true;
        };

        users.users.root.initialPassword = "root";

        networking.firewall.allowedTCPPorts = [ 22 ];
        microvm = {
          hypervisor = "qemu";

          interfaces = [
            {
              type = "user";
              id = "usernet";
              mac = "02:00:00:00:00:01";
            }
          ];
          forwardPorts = [
            {
              from = "host";
              host.port = 2222;
              guest.port = 22;
            }
          ];
        };
      };

    # microvm class is for Guests!, forwarded into server: nixos.microvm.vms.<name>
    microvm = {
      autostart = true;
    };
  };

}

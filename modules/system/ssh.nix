{
  den.aspects.ssh = {
    nixos = {
      services.openssh = {
        enable = true;
        openFirewall = false;

        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          PermitRootLogin = "no";
          X11Forwarding = false;
          AllowUsers = [ "dave" ];
        };
      };

      networking.firewall = {
        interfaces.tailscale0 = {
          allowedTCPPorts = [
            22
          ];
        };
      };
    };
  };
}

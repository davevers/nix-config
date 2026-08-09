{ den, ... }:
{
  den.aspects.server.ssh =
    { host, ... }:
    {
      nixos =
        { config, ... }:
        {
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
            enable = true;

            # Adjust to your actual LAN interface.
            allowedTCPPorts = [ 22 ];

            #   # Or eventually permit SSH only through Tailscale:
            #   interfaces."tailscale0".allowedTCPPorts = [ 22 ];
            # };
          };
        };
    };
}

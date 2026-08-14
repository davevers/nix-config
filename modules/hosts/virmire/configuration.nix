{
  den,
  lib,
  self,
  ...
}:
{
  den.hosts.x86_64-linux.virmire.users.dave = {
  };
  den.aspects.virmire =
    { host, user, ... }:
    {
      includes = [
        den.aspects.server
        den.aspects.pocket-id
      ];

      nixos =
        { config, ... }:
        let
          secret = "users/${user.userName}/password";
        in
        {
          imports = [
            ./_hardware-configuration.nix
          ];

          boot.loader.grub.enable = true;
          boot.loader.grub.device = "/dev/vda";

          networking.hostName = "virmire";
          system.stateVersion = lib.mkDefault "26.05";
          # security.sudo.wheelNeedsPassword = false;
          sops.secrets.${secret} = {
            sopsFile = self + /secrets/common.yaml;
            neededForUsers = true;
          };
          users.users.${user.userName}.hashedPasswordFile = config.sops.secrets.${secret}.path;
          networking.nftables.enable = true;

          networking.firewall = {
            enable = true;

            # Do not globally open 80/443 here.
            allowedTCPPorts = [ ];

            # Once SSH is only over Tailscale, you can trust the tailnet interface.
            trustedInterfaces = [
              "tailscale0"
            ];

            extraInputRules = ''
              # Allow HTTP/HTTPS only from Cloudflare IPv4 ranges.
              ip saddr {
                173.245.48.0/20,
                103.21.244.0/22,
                103.22.200.0/22,
                103.31.4.0/22,
                141.101.64.0/18,
                108.162.192.0/18,
                190.93.240.0/20,
                188.114.96.0/20,
                197.234.240.0/22,
                198.41.128.0/17,
                162.158.0.0/15,
                104.16.0.0/13,
                104.24.0.0/14,
                172.64.0.0/13,
                131.0.72.0/22
              } tcp dport { 80, 443 } accept

              # Cloudflare IPv6, if IPv6 is enabled on this server.
              ip6 saddr {
                2400:cb00::/32,
                2606:4700::/32,
                2803:f800::/32,
                2405:b500::/32,
                2405:8100::/32,
                2a06:98c0::/29,
                2c0f:f248::/32
              } tcp dport { 80, 443 } accept
            '';
          };
        };
    };
}

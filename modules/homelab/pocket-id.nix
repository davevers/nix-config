{ den, ... }:
{
  den.aspects.pocket-id =
    { host, ... }:
    {
      nixos =
        { config, pkgs, ... }:

        {
          services.pocket-id = {
            enable = true;

            settings = {
              APP_URL = "https://auth.td-home.xyz";

              # Only Caddy should connect directly to Pocket ID.
              HOST = "127.0.0.1";
              PORT = 1411;

              # Pocket ID is behind Caddy.
              TRUST_PROXY = true;
            };

            credentials = {
              ENCRYPTION_KEY = config.sops.secrets."pocket-id/encryption-key".path;
            };
          };

          sops.secrets."pocket-id/encryption-key" = { };
          sops.secrets."cloudflare/api-token" = {
            owner = "caddy";
            group = "caddy";
          };
          sops.templates."caddy-env" = {
            owner = "caddy";
            group = "caddy";
            mode = "0400";
            content = ''
              CLOUDFLARE_API_TOKEN=${config.sops.placeholder."cloudflare/api-token"}
            '';
          };

          services.caddy = {
            enable = true;

            package = pkgs.caddy.withPlugins {
              plugins = [
                "github.com/caddy-dns/cloudflare@v0.2.4"
              ];
              hash = "sha256-bzMqxWTqrJ1skZmRTXyEMCKStXpljbqe5r0Ve2cnBfM=";
            };

            environmentFile = config.sops.templates."caddy-env".path;

            virtualHosts = {
              "auth.td-home.xyz".extraConfig = ''
                tls {
                  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
                }
                reverse_proxy 127.0.0.1:1411
              '';

              "td-home.xyz".extraConfig = ''
                @webfinger path /.well-known/webfinger

                handle @webfinger {
                  header Content-Type application/jrd+json

                  respond `{
                    "subject": "acct:dave@td-home.xyz",
                    "links": [
                      {
                        "rel": "http://openid.net/specs/connect/1.0/issuer",
                        "href": "https://auth.td-home.xyz"
                      }
                    ]
                  }` 200
                }
              '';
            };
          };
        };
    };
}

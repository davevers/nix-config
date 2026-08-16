{ self, ... }:
{
  den.aspects.caddy = {
    nixos = { config, pkgs, ... }: {
      sops.secrets."cloudflare/api-token" = {
        sopsFile = self + /secrets/common.yaml;
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
          hash = "sha256-7GoH8YLCoPmPExQxoga2FHB58zQDoZVf1BBwkVi0SsQ=";
        };

        environmentFile = config.sops.templates."caddy-env".path;

        globalConfig = ''
          acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
        '';
      };
    };
  };
}

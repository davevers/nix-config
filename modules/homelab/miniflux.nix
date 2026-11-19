{
  den.aspects.miniflux = {
    nixos =
      { config, ... }:
      {
        services.miniflux = {
          enable = true;
          createDatabaseLocally = true;
          adminCredentialsFile = config.sops.templates."miniflux-env".path;
          config = {
            # qBittorrent already uses port 8080 on noveria.
            LISTEN_ADDR = "127.0.0.1:8081";
            BASE_URL = "https://feeds.td-home.xyz";
            HTTPS = 1;
            OAUTH2_PROVIDER = "oidc";
            OAUTH2_OIDC_DISCOVERY_ENDPOINT = "https://auth.td-home.xyz";
            OAUTH2_REDIRECT_URL = "https://feeds.td-home.xyz/oauth2/oidc/callback";
            # Link Pocket ID from the bootstrap account's settings first.
            OAUTH2_USER_CREATION = 0;
            DISABLE_LOCAL_AUTH = 0;
          };
        };

        sops.secrets = {
          "miniflux/admin-password" = { };
          "miniflux/oauth/client-id" = { };
          "miniflux/oauth/client-secret" = { };
        };

        # systemd reads this before starting the service's dynamic user.
        sops.templates."miniflux-env" = {
          mode = "0400";
          restartUnits = [ "miniflux.service" ];
          content = ''
            ADMIN_USERNAME=dave
            ADMIN_PASSWORD=${config.sops.placeholder."miniflux/admin-password"}
            OAUTH2_CLIENT_ID=${config.sops.placeholder."miniflux/oauth/client-id"}
            OAUTH2_CLIENT_SECRET=${config.sops.placeholder."miniflux/oauth/client-secret"}
          '';
        };

        services.caddy.virtualHosts."feeds.td-home.xyz".extraConfig = ''
          reverse_proxy 127.0.0.1:8081
        '';
      };
  };
}

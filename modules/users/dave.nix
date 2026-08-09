{ den, inputs, ... }:
{
  # user aspect
  den.aspects.dave =
    { config, ... }:
    {
      includes = [
        den.batteries.define-user
        den.batteries.primary-user
        (den.batteries.user-shell "fish")
        {
          nixos.hjem.extraModules = [
            inputs.hjem-impure.hjemModules.default
          ];
        }
      ];

      user = {
        extraGroups = [ "incus-admin" ];

        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINlPQ/Wscut3fZUcTdd7qMHvf6t/uMceAqIx28R3K55Z dave@loki"
        ];
      };

      hjem =
        { pkgs, ... }:
        {
          impure = {
            enable = true;
            dotsDir = "${../../dots}";
            dotsDirImpure = "/home/dave/workspace/nix-config/dots";
          };

          packages = [
            pkgs.xdg-utils
          ];

          xdg.mime-apps =
            let
              browser = "firefox.desktop";
            in
            {
              default-applications = {
                "text/html" = browser;
                "application/xhtml+xml" = browser;
                "x-scheme-handler/http" = browser;
                "x-scheme-handler/https" = browser;
                "x-scheme-handler/about" = browser;
                "x-scheme-handler/unknown" = browser;
              };
              added-associations = {
                "text/html" = browser;
                "application/xhtml+xml" = browser;
                "x-scheme-handler/http" = browser;
                "x-scheme-handler/https" = browser;
              };
            };
        };
    };
}

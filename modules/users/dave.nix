{ den, inputs, ... }:
{
  # user aspect
  den.aspects.dave = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      (den.batteries.user-shell "fish")
    ];

    user = {
      extraGroups = [ "incus-admin" ];
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

{
  den.aspects.firefox = {
    nixos = {
      programs.firefox = {
        enable = true;
      };
    };

    provides.to-users.hjem = {
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

{
  den.aspects.kitty =
    { host, user, ... }:
    {
      nixos =
        { pkgs, ... }:
        {
          environment.systemPackages = [
            pkgs.kitty
          ];
        };

      provides.to-users = {
        hjem =
          { config, ... }:
          {
            xdg.config.files =
              let
                dots = config.impure.dotsDir;
              in
              {
                "kitty/kitty.conf".source = dots + "/kitty/kitty.conf";
                "kitty/light-theme.auto.conf".source = dots + "/kitty/light-theme.auto.conf";
                "kitty/dark-theme.auto.conf".source = dots + "/kitty/dark-theme.auto.conf";
                "kitty/no-preference-theme.auto.conf".source = dots + "/kitty/no-preference-theme.auto.conf";
              };
          };
      };
    };
}

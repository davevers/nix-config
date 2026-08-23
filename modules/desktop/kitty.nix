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
              };
          };
      };
    };
}

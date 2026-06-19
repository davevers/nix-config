{
  den.aspects.ghostty =
    { host, user, ... }:
    {
      nixos =
        { pkgs, ... }:
        {
          environment.systemPackages = [
            pkgs.ghostty
          ];
        };
      hjem =
        { config, ... }:
        {
          xdg.config.files =
            let
              dots = config.impure.dotsDir;
            in
            {
              "ghostty/config.ghostty".source = dots + "/ghostty/config.ghostty";
            };
        };
    };
}

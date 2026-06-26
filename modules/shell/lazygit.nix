{
  den.aspects.shell = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.lazygit ];
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
              "lazygit/config.yml".source = dots + "/lazygit/config.yml";
            };
        };
    };
  };
}

{ self, ... }: {
  den.aspects.ghostty = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.ghostty
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
              "ghostty/config.ghostty".source = dots + "/ghostty/config.ghostty";
              "ghostty/themes".source = "${self}/dots/ghostty/themes";
            };
        };
    };
  };
}

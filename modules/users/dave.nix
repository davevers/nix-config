{ den, ... }:
{
  # user aspect
  den.aspects.dave = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      (den.batteries.user-shell "fish")
      den.aspects.stylix
    ];

    homeManager =
      { pkgs, ... }:
      {
        programs.git = {
          settings.user.name = "Dave Verstrate";
          settings.user.email = "daverstrate@gmail.com";
        };
        stylix = {
          polarity = "light";
          base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-dawn.yaml";
          cursor = {
            name = "BreezeX-RosePineDawn-Linux";
            package = pkgs.rose-pine-cursor;
            size = 32;
          };
        };
      };
  };
}

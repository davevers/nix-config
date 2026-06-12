{
  den.aspects.desktop =
    {
      host,
      user,
      ...
    }:
    {
      homeManager =
        { config, ... }:
        {
          programs.fuzzel = {
            enable = true;
            settings = {
              main = {
                terminal = "kitty";
                dpi-aware = "no";
              };
            };
          };

          stylix.targets.fuzzel.fonts.override = {
            sansSerif = config.stylix.fonts.monospace;
          };
        };
    };
}

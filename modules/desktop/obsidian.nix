{ den, ... }:
{
  den.aspects.desktop =
    { host, user, ... }:
    {
      includes = [
        (den.batteries.unfree [
          "obsidian"
        ])
      ];
      homeManager = {
        programs.obsidian.enable = true;
      };
    };
}

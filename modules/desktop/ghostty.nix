{
  den.aspects.desktop =
    { host, user, ... }:
    {
      homeManager = {
        programs.ghostty = {
          enable = true;
        };
      };
    };
}

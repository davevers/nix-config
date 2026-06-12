{
  den.aspects.desktop =
    { host, user, ... }:
    {
      homeManager = {
        programs.kitty.enable = true;
      };
    };
}

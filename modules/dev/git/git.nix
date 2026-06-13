{
  den.aspects.dev =
    { user, ... }:
    {
      homeManager = {
        programs.git.enable = true;
      };
    };
}

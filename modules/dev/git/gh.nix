{
  den.aspects.dev =
    { user, ... }:
    {
      homeManager = {
        programs.gh = {
          enable = true;
          gitCredentialHelper.enable = true;
        };
      };
    };
}

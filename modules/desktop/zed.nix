{
  den.aspects.desktop =
    { host, user, ... }:
    {
      homeManager = {
        programs.zed-editor = {
          enable = true;
        };
      };
    };
}

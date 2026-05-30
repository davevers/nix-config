{
  den.aspects.dev =
    { user, ... }:
    {
      hjem =
        { pkgs, ... }:
        {
          packages = [
            pkgs.gh
          ];
        };
    };
}

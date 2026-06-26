{
  den.aspects.dev = {
    provides.to-users = {
      hjem =
        { pkgs, ... }:
        {
          packages = [
            pkgs.gh
          ];
        };
    };
  };
}

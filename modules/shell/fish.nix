{
  den.aspects.shell =
    { host, user, ... }:
    {
      nixos =
        { pkgs, ... }:
        {
          programs.fish = {
            enable = true;
            vendor = {
              completions.enable = true;
              config.enable = true;
              functions.enable = true;
            };
          };
        };
    };
}

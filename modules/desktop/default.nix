{
  den.aspects.desktop =
    { host, user, ... }:
    {
      homeManager =
        { pkgs, ... }:
        {
          home.packages = with pkgs; [
            seahorse
          ];
        };
    };
}

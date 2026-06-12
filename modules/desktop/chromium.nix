{
  den.aspects.desktop =
    { host, user, ... }:
    {
      homeManager =
        { pkgs, ... }:
        {
          # This enables Chromium policies; install the desired browser package explicitly.
          programs.chromium = {
            enable = true;
            package = pkgs.ungoogled-chromium;
          };
        };
    };
}

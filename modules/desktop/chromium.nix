{
  den.aspects.desktop = {
    nixos =
      { pkgs, ... }:
      {
        # This enables Chromium policies; install the desired browser package explicitly.
        programs.chromium = {
          enable = true;
        };
        environment.systemPackages = [
          pkgs.ungoogled-chromium
        ];
      };
  };
}

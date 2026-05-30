{
  den.aspects.desktop = {
    nixos =
      { pkgs, ... }:
      {
        programs.chromium = {
          enable = true;
        };
        environment.systemPackages = [
          pkgs.ungoogled-chromium
        ];
      };
  };
}

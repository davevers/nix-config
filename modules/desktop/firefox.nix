{ den, ... }:
{
  den.aspects.desktop = {
    includes = [
      (den.batteries.unfree [
        "firefox-bin"
        "firefox-bin-unwrapped"
      ])
    ];
    nixos =
      { pkgs, ... }:
      {
        programs.firefox.enable = true;
        programs.firefox.package = pkgs.firefox-bin;
      };
  };
}

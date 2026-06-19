{ den, ... }:
{
  den.aspects.obsidian = {
    includes = [
      (den.batteries.unfree [
        "obsidian"
      ])
    ];
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.obsidian ];
      };
  };
}

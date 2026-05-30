{ den, ... }:
{
  den.aspects.desktop = {
    includes = [
      (den.batteries.unfree [
        "obsidian"
      ])
    ];
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [ obsidian ];
      };
  };
}

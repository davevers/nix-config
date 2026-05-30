{
  den.aspects.desktop = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [ vscodium.fhs ];
      };
  };
}

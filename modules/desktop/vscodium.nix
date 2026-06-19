{
  den.aspects.vscodium = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [ vscodium.fhs ];
      };
  };
}

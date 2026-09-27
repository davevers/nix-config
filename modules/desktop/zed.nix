{
  den.aspects.zed = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [ gram ];
      };
  };
}

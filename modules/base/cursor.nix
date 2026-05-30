{
  den.aspects.base = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.bibata-cursors
        ];
      };
  };
}

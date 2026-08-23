{
  den.aspects.shell = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.lazygit ];
      };
  };
}

{ den, ... }:
{
  den.aspects.desktop.noctalia = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          noctalia-shell
        ];
      };
  };
}

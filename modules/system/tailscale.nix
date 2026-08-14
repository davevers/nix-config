{ inputs, ... }:
{
  den.aspects.tailscale = {
    nixos =
      { pkgs, ... }:
      let
        unstable = import inputs.nixpkgs-unstable {
          system = pkgs.stdenv.hostPlatform.system;
        };
      in
      {
        services.tailscale = {
          enable = true;
          package = unstable.tailscale;
        };
      };
  };
}

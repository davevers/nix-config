{ inputs, ... }:
{
  flake-file.inputs = {
    noctalia = {
      url = "github:noctalia-dev/noctalia";
    };
  };

  den.aspects.noctalia = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
      };
  };
}

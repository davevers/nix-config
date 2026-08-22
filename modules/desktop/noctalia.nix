{ inputs, ... }:
{
  flake-file.inputs = {
    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
    };
    wallpkgs.url = "github:NotAShelf/wallpkgs";
  };

  flake-file.nixConfig = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  den.aspects.noctalia = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
      };

    provides.to-users = {
      hjem = {
        files = {
          "Pictures/wallpapers/rose-pine".source = inputs.wallpkgs + "/wallpapers/rose-pine";
        };
      };
    };
  };
}

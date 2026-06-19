{ inputs, ... }:
{
  flake-file.inputs = {
    helium-browser = {
      url = "github:ominit/helium-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.helium = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ inputs.helium-browser.packages."${pkgs.system}".helium ];
      };
  };
}

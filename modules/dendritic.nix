{ inputs, ... }:
{
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];

  # other inputs may be defined at a module using them.
  flake-file.inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/26.05";
    den.url = "github:denful/den/v0.17.0";
    flake-file.url = "github:vic/flake-file";
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hjem-impure = {
      url = "github:Rexcrazy804/hjem-impure";
    };
  };
}

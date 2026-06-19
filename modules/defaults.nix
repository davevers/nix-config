{
  lib,
  inputs,
  ...
}:
{
  # Keep this at the original install release. This should not track nixpkgs.
  den.default.nixos.system.stateVersion = "25.11";
  den.default.homeManager.home.stateVersion = "25.11";

  den.schema.user = {
    classes = lib.mkDefault [
      "hjem"
    ];
  };

  den.schema.host = {
    includes = [
      {
        nixos.hjem.extraModules = [
          inputs.hjem-impure.hjemModules.default
        ];
      }
    ];
  };
}

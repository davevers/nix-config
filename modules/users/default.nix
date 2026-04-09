{
  inputs,
  ...
}:
{
  flake.modules.homeManager.user-default =
    { pkgs, ... }:
    {
      home = {
        stateVersion = "25.05";
      };

      systemd.user.startServices = "sd-switch";

      nixpkgs = {
        overlays = [
          (final: _prev: {
            unstable = import inputs.nixpkgs-unstable {
              inherit (final) config;
              system = pkgs.stdenv.hostPlatform.system;
            };
          })
          inputs.nur.overlays.default
        ];
        config.allowUnfree = true;
      };
    };
}

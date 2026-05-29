{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          (final: _prev: {
            unstable = import inputs.nixpkgs-unstable {
              system = final.system;
            };
          })
        ];
        config = { };
      };
    };
}

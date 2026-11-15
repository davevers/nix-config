{ den, inputs, ... }:
{
  # user aspect
  den.aspects.dave =
    { config, ... }:
    {
      includes = [
        den.batteries.define-user
        den.batteries.primary-user
        (den.batteries.user-shell "fish")
        {
          nixos.hjem.extraModules = [
            inputs.hjem-impure.hjemModules.default
          ];
        }
      ];

      user = {
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINlPQ/Wscut3fZUcTdd7qMHvf6t/uMceAqIx28R3K55Z dave@loki"
        ];
      };

      hjem =
        { pkgs, ... }:
        {
          clobberFiles = true;
          impure = {
            enable = true;
            dotsDir = "${../../dots}";
            dotsDirImpure = "/home/dave/workspace/nix-config/dots";
          };

          packages = [
            pkgs.xdg-utils
          ];
        };
    };
}

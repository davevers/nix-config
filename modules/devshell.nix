{ inputs, ... }:

{
  flake-file.inputs = {
    jailed-agents.url = "github:davevers/jailed-agents";
  };
  perSystem =
    { pkgs, system, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          nixd
          nixfmt
          cowsay

          (inputs.jailed-agents.lib.${system}.makeJailedCodex {
            extraPkgs = [
              nixd
              nixfmt
            ];
          })
        ];

        shellHook = ''
          echo "nix-config devshell"
        '';
      };
    };
}

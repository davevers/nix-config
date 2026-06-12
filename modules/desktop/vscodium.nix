{
  den.aspects.desktop =
    { host, user, ... }:
    {
      homeManager =
        { pkgs, ... }:
        {
          programs.vscodium = {
            enable = true;
            mutableExtensionsDir = false;
            profiles.default.extensions = with pkgs.vscode-extensions; [
              jnoortheen.nix-ide
            ];
          };
        };
    };
}

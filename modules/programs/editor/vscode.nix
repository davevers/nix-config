{
  flake.modules.homeManager.coding =
    {
      pkgs,
      ...
    }:

    {
      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        mutableExtensionsDir = true;
      };
    };
}

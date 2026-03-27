{
  flake.modules.homeManager.coding =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        nvim
      ];
    };
}

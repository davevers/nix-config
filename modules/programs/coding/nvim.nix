{
  flake.modules.homeManager.neovim =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        neovim
      ];
    };
}

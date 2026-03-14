{
  pkgs,
  ...
}:
{
  imports = [
    ./noctalia.nix
    ./fuzzel.nix
  ];

  services.cliphist = {
    enable = true;
  };

  programs.cava.enable = true;
}

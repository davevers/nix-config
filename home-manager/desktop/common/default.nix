{
  imports = [
    ./noctalia.nix
    ./fuzzel.nix
  ];

  services.cliphist = {
    enable = true;
  };
}

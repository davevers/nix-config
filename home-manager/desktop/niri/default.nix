{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    # inputs.niri.nixosModules.niri
    inputs.niri.homeModules.niri # Import Niri's home-manager module
    inputs.niri.homeModules.stylix
    ./settings.nix # Your custom configuration files for Niri
    ./keybinds.nix
    ./outputs.nix
    ../common
  ];

  home.packages = with pkgs; [
    xwayland-satellite
    wl-clipboard
  ];
}

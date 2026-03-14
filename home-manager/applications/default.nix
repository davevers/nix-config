{
  pkgs,
  ...
}:
{
  imports = [
    ./firefox.nix
    ./spotify.nix
  ];

  # Gui apps

  home.packages = with pkgs; [
    proton-pass
    protonmail-desktop
    obsidian
    seahorse
    whatsapp-electron
  ];

}

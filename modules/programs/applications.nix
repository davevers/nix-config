{
  flake.modules.home-manager.applications =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        proton-pass
        protonmail-desktop
        obsidian
        seahorse
        whatsapp-electron
      ];

      programs.spicetify = {
        enable = true;
      };
    };
}

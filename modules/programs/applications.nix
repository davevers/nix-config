{
  inputs,
  ...
}:
{
  flake.modules.homeManager.applications =
    { pkgs, ... }:
    {
      imports = [
        inputs.spicetify-nix.homeManagerModules.spicetify
      ];

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

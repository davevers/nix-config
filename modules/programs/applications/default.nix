{
  inputs,
  self,
  ...
}:
{
  flake.modules.homeManager.common-applications =
    { pkgs, ... }:
    {
      imports = [
        inputs.spicetify-nix.homeManagerModules.spicetify
        self.modules.homeManager.firefox
        self.modules.homeManager.kitty
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

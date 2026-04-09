{
  self,
  inputs,
  ...
}:
{
  flake.modules.homeManager.niri =
    { pkgs, ... }:
    {
      imports = [
        inputs.niri.homeModules.niri
        inputs.niri.homeModules.stylix
        self.modules.homeManager.fuzzel
        self.modules.homeManager.noctalia
      ];

      programs.niri = {
        enable = true;
        package = pkgs.niri;
      };

      home.packages = with pkgs; [
        xwayland-satellite
        wl-clipboard

        nautilus

        libnotify
        alsa-utils
        alsa-firmware
        brightnessctl
      ];

      services.cliphist = {
        enable = true;
      };
    };
}

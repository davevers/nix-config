{
  flake.modules.homeManager.desktop-niri =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        xwayland-satellite
        wl-clipboard
      ];

      services.cliphist = {
        enable = true;
      };
    };
}

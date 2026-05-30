{ den, ... }:
{
  den.aspects.desktop =
    { host, user, ... }:
    {
      nixos =
        { pkgs, ... }:
        {
          programs.niri.enable = true;
          xdg.portal = {
            enable = true;
            wlr.enable = true;
            extraPortals = [
              pkgs.xdg-desktop-portal-gtk
              pkgs.xdg-desktop-portal-gnome
            ];
            config.common.default = "*";
          };
        };

      hjem =
        { pkgs, ... }:
        {
          packages = with pkgs; [
            cliphist
            wl-clipboard
          ];
          xdg.config.files = {
            "niri/config.kdl".source = ./config.kdl;
            "niri/keybinds.kdl".source = ./keybinds.kdl;
            "niri/outputs.kdl".source = ./outputs.kdl;
          };
        };
    };
}

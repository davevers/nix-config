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

      homeManager =
        { config, pkgs, ... }:
        let
          theme = config.lib.stylix.colors.withHashtag;
        in
        {
          home.packages = with pkgs; [
            cliphist
            wl-clipboard
          ];
          xdg.configFile = {
            "niri/config.kdl".source = ./config.kdl;
            "niri/keybinds.kdl".source = ./keybinds.kdl;
            "niri/outputs.kdl".source = ./outputs.kdl;
            "niri/stylix.kdl".text = ''
              layout {
                  border {
                      active-color   "${theme.base0D}"
                      inactive-color "${theme.base03}"
                      urgent-color   "${theme.base08}"
                  }
                  tab-indicator {
                      active-color   "${theme.base0D}"
                      inactive-color "${theme.base03}"
                      urgent-color   "${theme.base08}"
                  }
              }
            '';
          };
        };
    };
}

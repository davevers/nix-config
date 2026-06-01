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
        { config, pkgs, ... }:
        let
          theme = config.local.theme.base16;
          hex = theme.helpers.hex;
          rgba = theme.helpers.rgba;
        in
        {
          packages = with pkgs; [
            cliphist
            wl-clipboard
          ];
          xdg.config.files = {
            "niri/config.kdl".source = ./config.kdl;
            "niri/keybinds.kdl".source = ./keybinds.kdl;
            "niri/outputs.kdl".source = ./outputs.kdl;
            "niri/theme.kdl".text = ''
              layout {
                  border {
                      on
                      width 2
                      active-color   "${hex theme.base0D}"
                      inactive-color "${hex theme.base03}"
                      urgent-color   "${hex theme.base08}"
                  }

                  tab-indicator {
                      active-color   "${hex theme.base0D}"
                      inactive-color "${hex theme.base03}"
                      urgent-color   "${hex theme.base08}"
                  }

                  insert-hint {
                      color "#${rgba theme.base0D "80"}"
                  }
              }
            '';
          };
        };
    };
}

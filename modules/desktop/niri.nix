{ den, ... }:
{
  den.aspects.niri = {
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
        environment.systemPackages = with pkgs; [
          rose-pine-cursor
          cliphist
          wl-clipboard
        ];
      };

    provides.to-users = {
      hjem =
        { config, pkgs, ... }:
        {
          xdg.config.files =
            let
              dots = config.impure.dotsDir;
            in
            {
              "niri".source = dots + "/niri";
            };
        };
    };
  };
}

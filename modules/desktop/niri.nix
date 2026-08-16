{ den, ... }:
{
  den.aspects.niri = {
    nixos =
      { pkgs, ... }:
      let
        polkit-agent = pkgs.writeShellScriptBin "polkit-agent" ''
            exec ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
        '';
      in
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
          polkit-agent
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

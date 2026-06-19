{ self, ... }:
{
  den.aspects.greeterd = {
    nixos =
      { pkgs, ... }:
      {
        services.greetd =
          let
            niri-conf = pkgs.writeText "niri-gtkgreet-config" ''
              spawn-sh-at-startup "${pkgs.regreet}/bin/regreet; ${pkgs.niri}/bin/niri msg action quit --skip-confirmation"
              hotkey-overlay {
                  skip-at-startup
              }
              cursor {
                  xcursor-theme "BreezeX-RosePineDawn-Linux"
                  xcursor-size 32
              }
            '';
          in
          {
            enable = true;
            settings = {
              default_session = {
                command = ''
                  ${pkgs.dbus}/bin/dbus-run-session ${pkgs.niri}/bin/niri --config ${niri-conf}
                '';
              };
              user = "greeter";
            };
          };

        programs.regreet = {
          enable = true;
          font.name = "Adwaita Sans";
          iconTheme.name = "Papirus";
          iconTheme.package = pkgs.papirus-icon-theme;
          theme.name = "adw-gtk3";
          theme.package = pkgs.adw-gtk3;
          extraCss = ./gtk.css;
          settings.background.path = "${self}/assets/wallpapers/sam-ferrara-uOi3lg8fGl4-unsplash.jpg";
          settings.background.fit = "Cover";
        };

        security.pam.services.login.enableGnomeKeyring = true;
        services.gnome.gnome-keyring.enable = true;
      };
  };
}

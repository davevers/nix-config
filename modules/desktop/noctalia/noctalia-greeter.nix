{
  den.aspects.noctalia-greeter = {
    nixos =
      { pkgs, ... }:
      {
        services.displayManager.noctalia-greeter = {
          enable = true;
          passwordlessSyncUsers = [ "dave" ];
          settings = {
            cursor.size = 24;
            keyboard.layout = "us";
            output = {
              layout = "DP-1:0,0; eDP-1:3440,360";
              scales = "DP-1:1.0; eDP-1:2.0;";
            };
          };
          cursorTheme = {
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Ice";
          };
        };

        security.pam.services.login.enableGnomeKeyring = true;
        services.gnome.gnome-keyring.enable = true;
      };
  };
}

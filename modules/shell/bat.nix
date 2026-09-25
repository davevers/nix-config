{ self, ... }:
{
  den.aspects.shell = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.bat ];
      };

    provides.to-users = {
      hjem = {
        xdg.config.files = {
          "bat/config".text = ''
            --theme-dark="Evergarden Fall"
            --theme-light="Evergarden Summer"
            --theme=auto
          '';
          "bat/themes/Rose-Pine-Dawn.tmTheme".source = "${self}/dots/bat/Rose-Pine-Dawn.tmTheme";
          "bat/themes/evergarden-fall.tmTheme".source = "${self}/dots/bat/evergarden-fall.tmTheme";
          "bat/themes/evergarden-summer.tmTheme".source = "${self}/dots/bat/evergarden-summer.tmTheme";
        };
      };
    };
  };
}

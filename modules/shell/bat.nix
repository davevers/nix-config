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
          "bat/config".text = "--theme=\"Rose-Pine-Dawn\"";
          "bat/themes/Rose-Pine-Dawn.tmTheme".source = "${self}/dots/bat/Rose-Pine-Dawn.tmTheme";
        };
      };
    };
  };
}

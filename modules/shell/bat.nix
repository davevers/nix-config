{ self, ... }:
{
  den.aspects.shell =
    { host, user, ... }:
    {
      nixos =
        { pkgs, ... }:
        {
          environment.systemPackages = [ pkgs.bat ];
        };
      hjem = {
        xdg.config.files = {
          "bat/config".text = "--theme=\"Rose-Pine-Dawn\"";
          "bat/themes/Rose-Pine-Dawn.tmTheme".source = "${self}/dots/bat/Rose-Pine-Dawn.tmTheme";
        };
      };
    };
}

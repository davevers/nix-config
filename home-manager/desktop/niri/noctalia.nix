{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;

    settings = {
      bar = {
        density = "default";
        position = "top";
        barType = "simple";
        showCapsule = true;
        widgets = {
          left = [
            {
              id = "Launcher";
            }
            {
              id = "Workspace";
              hideUnoccupied = false;
              labelMode = "index";
            }
            {
              id = "ActiveWindow";
            }
          ];
          center = [
            {
              id = "Clock";
              formatHorizontal = "HH:mm ddd, MMM dd";
              formatVertical = "HH mm";
              useMonospacedFont = true;
              usePrimaryColor = false;
            }
            {
              id = "MediaMini";
            }
          ];
          right = [
            {
              id = "Tray";
            }

            {
              id = "NotificationHistory";
            }
            {
              id = "Volume";
            }
            {
              id = "Battery";
            }
            {
              id = "ControlCenter";
              useDistroLogo = true;
              icon = "noctalia"; # used when distro logo is set to false
              enableColorization = true;
            }
          ];
        };
      };

      general = {
        avatarImage = "/home/${config.home.username}/.face";
      };

      colorSchemes.predefinedScheme = "Catppuccin-Lavender";

      location = {
        analogClockInCalendar = "true";
        name = "Rotterdam, NL";
        useFahrenheit = true;
      };
    };
    # this may also be a string or a path to a JSON file.
  };
}

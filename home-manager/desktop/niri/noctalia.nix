{
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;

    settings = {
      bar = {
        density = "compact";
        position = "top";
        floating = false;
        showCapsule = true;
        useSeparateOpacity = false;
        showOutline = false;
        outerCorners = false;
        widgets = {
          left = [
            {
              id = "SystemMonitor";
              compactMode = false;
            }
            {
              id = "MediaMini";
            }
          ];
          center = [
            {
              id = "Workspace";
              hideUnoccupied = false;
              labelMode = "none";
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
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "Volume";
            }
            {
              id = "Battery";
            }
            {
              id = "Clock";
              formatHorizontal = "HH:mm dd MMM";
              formatVertical = "HH mm";
              useMonospacedFont = true;
              usePrimaryColor = false;
            }
            {
              id = "ControlCenter";
              useDistroLogo = true;
              enableColorization = true;
            }
          ];
        };
      };

      appLauncher = {
        enableClipboardHistory = true;
        autoPasteClipboard = false;
        position = "center";
        terminalCommand = "kitty";
        density = "compact";
        showCategories = false;
      };

      dock = {
        enabled = false;
        };

      general = {
        animationSpeed = 1.5;
        compactLockScreen = true;
        lockScreenBlur = 0.8;
        enableShadows = true;
        avatarImage = "/home/${config.home.username}/.face";
      };

      ui = {
        panelsAttachedToBar = true;
        settingsPanelMode = "centered";
      };

      location = {
        analogClockInCalendar = "true";
        name = "Rotterdam, NL";
        useFahrenheit = false;
        weatherShowEffects = false;
      };
    };
    # this may also be a string or a path to a JSON file.
  };
}

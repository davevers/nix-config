{
  inputs,
  ...
}:

{
  flake.modules.homeManager.noctalia =
    {
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
            density = "default";
            position = "left";
            floating = false;
            showCapsule = true;
            useSeparateOpacity = false;
            showOutline = false;
            outerCorners = true;
            marginHorizontal = 8;
            marginVertical = 8;
            contentPadding = 8;
            widgets = {
              left = [
                {
                  id = "Workspace";
                  hideUnoccupied = false;
                  labelMode = "none";
                }
              ];
              center = [
                {
                  id = "Clock";
                }
                {
                  id = "NotificationHistory";
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
                  id = "Network";
                }
                {
                  id = "Bluetooth";
                }
                {
                  id = "Volume";
                }
                {
                  id = "SystemMonitor";
                }
                {
                  id = "Battery";
                  showNoctaliaPerformance = true;
                  showPowerProfiles = true;
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

          sessionMenu = {
            largeButtonsStyle = false;
            powerOptions = [
              {
                enabled = true;
                action = "suspend";
                keybind = "S";
              }
              {
                enabled = true;
                action = "hibernate";
                keybind = "H";
              }
              {
                enabled = true;
                action = "reboot";
                keybind = "R";
              }
              {
                enabled = true;
                action = "logout";
                keybind = "L";
              }
              {
                enabled = true;
                action = "shutdown";
                keybind = "P";
              }
            ];
          };

          idle = {
            enabled = true;
            lockTimeout = 180;
            screenOffTimeout = 300;
            suspendTimeout = 900;
          };

          wallpaper = {
            enabled = true;
            overviewEnabled = true;
          };
        };
      };
    };
}

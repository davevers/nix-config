{
  pkgs,
  inputs,
  ...
}:

{
  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      spawn-at-startup = [
        {
          command = [
            "noctalia-shell"
          ];
        }
      ];

      input = {
        keyboard = {
          track-layout = "global";
          repeat-delay = 500;
          repeat-rate = 40;
          xkb = {
            layout = "us";
            variant = "intl";
            options = "compose:ralt,caps:ctrl_modifier,caps:escape_shifted_capslock";
          };
        };

        touchpad = {
          tap = true;
          dwt = true;
          natural-scroll = true;
          accel-speed = 0.5;
          accel-profile = "adaptive";
          scroll-factor = 1.2;
          scroll-method = "two-finger";
          tap-button-map = "left-right-middle";
          click-method = "clickfinger";
        };
        mouse = {
          accel-speed = 0.2;
          accel-profile = "flat";
          scroll-factor = 1.0;
          scroll-method = "no-scroll";
        };
        tablet= {
            map-to-output = "DP-3";
        };

        # warp-mouse-to-focus
        # focus-follows-mouse max-scroll-amount="0%"
        workspace-auto-back-and-forth = true;
      };


      gestures.hot-corners.enable = false;

      layout = {
        gaps = 12;
        center-focused-column = "never";
        preset-column-widths = [
            { proportion = 1. / 3.; }
            { proportion = 1. / 2.; }
            { proportion = 2. / 3.; }
        ];
        default-column-width.proportion = 0.5;
        always-center-single-column = true;
    	border = {
          enable = true;
	  width = 2;
	};
	focus-ring = {
	  enable = false;
	};
      };

      hotkey-overlay.skip-at-startup = true;

      prefer-no-csd = true;

      screenshot-path = "~/Pictures/Screenshots/Screenshot_%Y-%m-%d %H-%M-%S.png";

      window-rules = [
        {
          matches = [
            {
              app-id = "firefox$";
              title = "^Picture-in-Picture$";
            }
          ];
          open-floating = true;
        }
        {
          matches = [
            { app-id = "^org\\.keepassxc\\.KeePassXC$"; }
            { app-id = "^org\\.gnome\\.World\\.Secrets$"; }
          ];
          block-out-from = "screen-capture";
        }
        {
          geometry-corner-radius = {
            top-left = 12.0;
            top-right = 12.0;
            bottom-left = 12.0;
            bottom-right = 12.0;
          };
          clip-to-geometry = true;
        }
      ];
    };
  };
}

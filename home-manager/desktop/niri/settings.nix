{
  pkgs,
  config,
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
        tablet = {
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
          # set to stylix foregrond color
          active.color = config.lib.stylix.colors.withHashtag.base05;
          width = 2;
        };
        focus-ring = {
          enable = false;
        };
      };

      hotkey-overlay.skip-at-startup = true;

      prefer-no-csd = true;

      screenshot-path = "~/Pictures/Screenshots/Screenshot_%Y-%m-%d %H-%M-%S.png";
    };
  };
}

{ self, inputs, ... }:
{
  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        extraPackages = with pkgs; [
          xwayland-satellite
          wl-clipboard
          nautilus
          libnotify
          alsa-utils
          alsa-firmware
          brightnessctl
        ];
        v2-settings = true;
        settings =
          let
            noctaliaExe = lib.getExe self'.packages.myNoctalia;
          in
          {
            spawn-at-startup = [ noctaliaExe ];

            xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

            hotkey-overlay.skip-at-startup = true;

            prefer-no-csd = true;

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
                tap = _: { };
                dwt = _: { };
                natural-scroll = _: { };
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

              workspace-auto-back-and-forth = true;
            };

            layout = {
              gaps = 12;
              always-center-single-column = true;
              border = {
                width = 2;
              };
              focus-ring = {
                off = _: { };
              };
            };

            outputs = {
              "DP-1" = {
                mode = "3440x1440@59.973";
                scale = 1.0;
                position = _: {
                  props = {
                    x = 0;
                    y = 0;
                  };
                };
              };
              "eDP-1" = {
                mode = _: {
                  props = [
                    "1920x1080@59.963"
                    { custom = true; }
                  ];
                };
                scale = 1.0;
                position = _: {
                  props = {
                    x = 3440;
                    y = 360;
                  };
                };
              };
            };

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
                geometry-corner-radius = 12;
                clip-to-geometry = true;
                draw-border-with-background = false;
              }
            ];

            layer-rules = [
              {
                matches = [
                  { namespace = "^noctalia-overview*"; }
                ];
                place-within-backdrop = true;
              }
            ];

            binds =
              let
                noctalia =
                  cmd:
                  [
                    noctaliaExe
                    "ipc"
                    "call"
                  ]
                  ++ (pkgs.lib.splitString " " cmd);
              in
              {
                "Mod+S".spawn = noctalia "launcher toggle";

                "XF86AudioRaiseVolume".spawn = noctalia "volume increase"; # output increase
                "XF86AudioLowerVolume".spawn = noctalia "volume decrease"; # output decrease
                "XF86AudioMute".spawn = noctalia "volume muteOutput"; # output mute
                "shift+XF86AudioRaiseVolume".spawn = noctalia "volume increaseInput"; # input increase
                "shift+XF86AudioLowerVolume".spawn = noctalia "volume decreaseInput"; # input decrease
                "shift+XF86AudioMute".spawn = noctalia "volume muteInput"; # input mute
                "control+XF86AudioMute".spawn = noctalia "volume togglePanel"; # open volume panel

                "XF86AudioPlay".spawn = noctalia "media playPause";
                "XF86AudioNext".spawn = noctalia "media next";
                "XF86AudioPrev".spawn = noctalia "media previous";

                "XF86MonBrightnessUp".spawn = noctalia "brightness increase";
                "XF86MonBrightnessDown".spawn = noctalia "brightness decrease";

                "Mod+Alt+L".spawn = noctalia "lockScreen lock";
                "Mod+Alt+P".spawn = noctalia "sessionMenu toggle";

                "Mod+Shift+Slash".show-hotkey-overlay = _: { };
                "Mod+Return".spawn = lib.getExe pkgs.kitty;

                "Mod+O" = _: {
                  content.toggle-overview = _: { };
                  props.repeat = false;
                };

                "Mod+Space".spawn = lib.getExe pkgs.fuzzel;

                "Mod+Q" = _: {
                  content.close-window = _: { };
                  props.repeat = false;
                };

                "Mod+H".focus-column-left = _: { };
                "Mod+J".focus-window-down = _: { };
                "Mod+K".focus-window-up = _: { };
                "Mod+L".focus-column-right = _: { };

                "Mod+Shift+H".move-column-left = _: { };
                "Mod+Shift+J".move-window-down = _: { };
                "Mod+Shift+K".move-window-up = _: { };
                "Mod+Shift+L".move-column-right = _: { };

                "Mod+Home".focus-column-first = _: { };
                "Mod+End".focus-column-last = _: { };
                "Mod+Shift+Home".move-column-to-first = _: { };
                "Mod+Shift+End".move-column-to-last = _: { };

                "Mod+Ctrl+H".focus-monitor-left = _: { };
                "Mod+Ctrl+J".focus-monitor-down = _: { };
                "Mod+Ctrl+K".focus-monitor-up = _: { };
                "Mod+Ctrl+L".focus-monitor-right = _: { };

                "Mod+Shift+Ctrl+H".move-column-to-monitor-left = _: { };
                "Mod+Shift+Ctrl+J".move-column-to-monitor-down = _: { };
                "Mod+Shift+Ctrl+K".move-column-to-monitor-up = _: { };
                "Mod+Shift+Ctrl+L".move-column-to-monitor-right = _: { };

                "Mod+Page_Down".focus-workspace-down = _: { };
                "Mod+Page_Up".focus-workspace-up = _: { };
                "Mod+U".focus-workspace-down = _: { };
                "Mod+I".focus-workspace-up = _: { };
                "Mod+Ctrl+Page_Down".move-column-to-workspace-down = _: { };
                "Mod+Ctrl+Page_Up".move-column-to-workspace-up = _: { };
                "Mod+Shift+U".move-column-to-workspace-down = _: { };
                "Mod+Shift+I".move-column-to-workspace-up = _: { };

                "Mod+Shift+Page_Down".move-workspace-down = _: { };
                "Mod+Shift+Page_Up".move-workspace-up = _: { };
                "Mod+Ctrl+Shift+U".move-workspace-down = _: { };
                "Mod+Ctrl+Shift+I".move-workspace-up = _: { };

                "Mod+WheelScrollDown" = _: {
                  content.focus-workspace-down = _: { };
                  props.cooldown-ms = 150;
                };
                "Mod+WheelScrollUp" = _: {
                  content.focus-workspace-up = _: { };
                  props.cooldown-ms = 150;
                };
                "Mod+Ctrl+WheelScrollDown" = _: {
                  content.move-column-to-workspace-down = _: { };
                  props.cooldown-ms = 150;
                };
                "Mod+Ctrl+WheelScrollUp" = _: {
                  content.move-column-to-workspace-up = _: { };
                  props.cooldown-ms = 150;
                };

                "Mod+WheelScrollRight".focus-column-right = _: { };
                "Mod+WheelScrollLeft".focus-column-left = _: { };
                "Mod+Shift+WheelScrollRight".move-column-right = _: { };
                "Mod+Shift+WheelScrollLeft".move-column-left = _: { };

                "Mod+1".focus-workspace = 1;
                "Mod+2".focus-workspace = 2;
                "Mod+3".focus-workspace = 3;
                "Mod+4".focus-workspace = 4;
                "Mod+5".focus-workspace = 5;
                "Mod+6".focus-workspace = 6;
                "Mod+7".focus-workspace = 7;
                "Mod+8".focus-workspace = 8;
                "Mod+9".focus-workspace = 9;
                "Mod+Shift+1".move-column-to-workspace = 1;
                "Mod+Shift+2".move-column-to-workspace = 2;
                "Mod+Shift+3".move-column-to-workspace = 3;
                "Mod+Shift+4".move-column-to-workspace = 4;
                "Mod+Shift+5".move-column-to-workspace = 5;
                "Mod+Shift+6".move-column-to-workspace = 6;
                "Mod+Shift+7".move-column-to-workspace = 7;
                "Mod+Shift+8".move-column-to-workspace = 8;
                "Mod+Shift+9".move-column-to-workspace = 9;

                "Mod+Tab".focus-workspace-previous = _: { };

                "Mod+BracketLeft".consume-or-expel-window-left = _: { };
                "Mod+BracketRight".consume-or-expel-window-right = _: { };

                "Mod+Shift+Comma".consume-window-into-column = _: { };
                "Mod+Shift+Period".expel-window-from-column = _: { };

                "Mod+R".switch-preset-column-width = _: { };
                "Mod+Shift+R".switch-preset-window-height = _: { };
                "Mod+Ctrl+R".reset-window-height = _: { };
                "Mod+F".maximize-column = _: { };
                "Mod+Shift+F".fullscreen-window = _: { };

                "Mod+Ctrl+F".expand-column-to-available-width = _: { };

                "Mod+Shift+C".center-column = _: { };

                "Mod+Ctrl+C".center-visible-columns = _: { };

                "Mod+Minus".set-column-width = "-10%";
                "Mod+Equal".set-column-width = "+10%";

                "Mod+Shift+Minus".set-window-height = "-10%";
                "Mod+Shift+Equal".set-window-height = "+10%";

                "Mod+T".toggle-window-floating = _: { };
                "Mod+Shift+T".switch-focus-between-floating-and-tiling = _: { };

                "Mod+W".toggle-column-tabbed-display = _: { };

                "Print".screenshot = _: { };
                "Ctrl+Print".screenshot-screen = _: { };
                "Alt+Print".screenshot-window = _: { };

                "Mod+Escape" = _: {
                  content.toggle-keyboard-shortcuts-inhibit = _: { };
                  props.allow-inhibiting = false;
                };
              };
          };
      };
    };
}

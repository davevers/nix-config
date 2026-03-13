{
  config,
  pkgs,
  ...
}:

let
  noctalia = cmd: [
    "noctalia-shell" "ipc" "call"
  ] ++ (pkgs.lib.splitString " " cmd);
in
{
  programs.niri.settings.binds =
    with config.lib.niri.actions;
    {
      "XF86AudioRaiseVolume".action.spawn = noctalia "volume increase"; # output increase
      "XF86AudioLowerVolume".action.spawn = noctalia "volume decrease"; # output decrease
      "XF86AudioMute".action.spawn = noctalia "volume muteOutput"; # output mute
      "shift+XF86AudioRaiseVolume".action.spawn = noctalia "volume increaseInput"; # input increase
      "shift+XF86AudioLowerVolume".action.spawn = noctalia "volume decreaseInput"; # input decrease
      "shift+XF86AudioMute".action.spawn = noctalia "volume muteInput"; # input mute
      "control+XF86AudioMute".action.spawn = noctalia "volume togglePanel"; # open volume panel

      "XF86AudioPlay".action.spawn = noctalia "media playPause";
      "XF86AudioNext".action.spawn = noctalia "media next";
      "XF86AudioPrev".action.spawn = noctalia "media previous";

      "super+Alt+L".action.spawn = noctalia "lockScreen lock";
      "super+Alt+P".action.spawn = noctalia "sessionMenu toggle";

      "Mod+Shift+Slash".action = show-hotkey-overlay;
      "Mod+Return".action.spawn =  "kitty";

      "Mod+O" = {
        action = toggle-overview;
        repeat = false;
      };

      "super+Space".action.spawn = noctalia "launcher toggle";

      "Mod+Q" = {
        action = close-window;
        repeat = false;
      };

      "Mod+H".action = focus-column-left;
      "Mod+J".action = focus-window-down;
      "Mod+K".action = focus-window-up;
      "Mod+L".action = focus-column-right;

      "Mod+Shift+H".action = move-column-left;
      "Mod+Shift+J".action = move-window-down;
      "Mod+Shift+K".action = move-window-up;
      "Mod+Shift+L".action = move-column-right;

      "Mod+Home".action = focus-column-first;
      "Mod+End".action = focus-column-last;
      "Mod+Shift+Home".action = move-column-to-first;
      "Mod+Shift+End".action = move-column-to-last;

      "Mod+Ctrl+H".action = focus-monitor-left;
      "Mod+Ctrl+J".action = focus-monitor-down;
      "Mod+Ctrl+K".action = focus-monitor-up;
      "Mod+Ctrl+L".action = focus-monitor-right;

      "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
      "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
      "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
      "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

      "Mod+Page_Down".action = focus-workspace-down;
      "Mod+Page_Up".action = focus-workspace-up;
      "Mod+U".action = focus-workspace-down;
      "Mod+I".action = focus-workspace-up;
      "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
      "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
      "Mod+Shift+U".action = move-column-to-workspace-down;
      "Mod+Shift+I".action = move-column-to-workspace-up;

      "Mod+Shift+Page_Down".action = move-workspace-down;
      "Mod+Shift+Page_Up".action = move-workspace-up;
      "Mod+Ctrl+Shift+U".action = move-workspace-down;
      "Mod+Ctrl+Shift+I".action = move-workspace-up;

      "Mod+WheelScrollDown" = {
        action = focus-workspace-down;
        cooldown-ms = 150;
      };
      "Mod+WheelScrollUp" = {
        action = focus-workspace-up;
        cooldown-ms = 150;
      };
      "Mod+Ctrl+WheelScrollDown" = {
        action = move-column-to-workspace-down;
        cooldown-ms = 150;
      };
      "Mod+Ctrl+WheelScrollUp" = {
        action = move-column-to-workspace-up;
        cooldown-ms = 150;
      };

      "Mod+WheelScrollRight".action = focus-column-right;
      "Mod+WheelScrollLeft".action = focus-column-left;
      "Mod+Shift+WheelScrollRight".action = move-column-right;
      "Mod+Shift+WheelScrollLeft".action = move-column-left;

      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;
      "Mod+Shift+6".action.move-column-to-workspace = 6;
      "Mod+Shift+7".action.move-column-to-workspace = 7;
      "Mod+Shift+8".action.move-column-to-workspace = 8;
      "Mod+Shift+9".action.move-column-to-workspace = 9;

      "Mod+Tab".action = focus-workspace-previous;

      "Mod+BracketLeft".action = consume-or-expel-window-left;
      "Mod+BracketRight".action = consume-or-expel-window-right;

      "Mod+Shift+Comma".action = consume-window-into-column;
      "Mod+Shift+Period".action = expel-window-from-column;

      "Mod+R".action = switch-preset-column-width;
      "Mod+Shift+R".action = switch-preset-window-height;
      "Mod+Ctrl+R".action = reset-window-height;
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;

      "Mod+Ctrl+F".action = expand-column-to-available-width;

      "Mod+Shift+C".action = center-column;

      "Mod+Ctrl+C".action = center-visible-columns;

      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";

      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      "Mod+T".action = toggle-window-floating;
      "Mod+Shift+T".action = switch-focus-between-floating-and-tiling;

      "Mod+W".action = toggle-column-tabbed-display;

      "Print".action.screenshot = [];
      "Ctrl+Print".action.screenshot-screen = [];
      "Alt+Print".action.screenshot-window = [];

      "Mod+Escape" = {
        action = toggle-keyboard-shortcuts-inhibit;
        allow-inhibiting = false;
      };
  };
}

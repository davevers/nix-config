{
  den.aspects.desktop =
    { host, user, ... }:
    {
      nixos = {
        programs.dms-shell = {
          enable = true;

          systemd = {
            enable = true; # Systemd service for auto-start
            restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
          };

          # Core features
          enableSystemMonitoring = true; # System monitoring widgets (dgop)
          enableVPN = false; # VPN management widget
          enableDynamicTheming = false; # Wallpaper-based theming (matugen)
          enableAudioWavelength = true; # Audio visualizer (cava)
          enableCalendarEvents = false; # Calendar integration (khal)
          enableClipboardPaste = true; # Pasting from the clipboard history (wtype)
        };

        services.displayManager.dms-greeter = {
          enable = true;
          compositor.name = "niri"; # Or "hyprland" or "sway"
          configHome = "/home/dave";
        };
      };

      hjem = {
        xdg.config.files = {
          "DankMaterialShell/settings.json".source = ./settings.json;
          "DankMaterialShell/theme.json".source = ./theme.json;
        };
      };
    };
}

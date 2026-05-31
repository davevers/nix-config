{
  den.aspects.desktop =
    { host, user, ... }:
    let
      userName = if builtins.isAttrs user then user.name else user;
      userHome = "/home/${userName}";
    in
    {
      nixos =
        { config, lib, ... }:
        {
          options.local.dms.greeterUser = lib.mkOption {
            type = lib.types.str;
            description = "User whose DMS settings should be used by the greeter.";
          };

          config = {
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
              configHome = "/home/${config.local.dms.greeterUser}";
            };
          };
        };

      hjem =
        { pkgs, ... }:
        {
          xdg.config.files = {
            "DankMaterialShell/settings.json" = {
              generator = (pkgs.formats.json { }).generate "dms-settings.json";
              value = (builtins.fromJSON (builtins.readFile ./settings.json)) // {
                customThemeFile = "${userHome}/.config/DankMaterialShell/theme.json";
              };
            };
            "DankMaterialShell/theme.json".source = ./theme.json;
          };
        };
    };
}

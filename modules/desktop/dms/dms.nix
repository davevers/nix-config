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
        { config, pkgs, ... }:
        let
          theme = config.local.theme.base16;
          hex = theme.helpers.hex;
          textColor = if theme.variant == "dark" then theme.base06 else theme.base05;
          outlineColor = if theme.variant == "dark" then theme.base05 else theme.base04;
          secondaryColor = if theme.variant == "dark" then theme.base0D else theme.base0A;
          primaryText = if theme.variant == "dark" then theme.base00 else theme.base01;
          dmsTheme = {
            background = hex theme.base00;
            backgroundText = hex textColor;
            error = hex theme.base08;
            info = hex theme.base0A;
            outline = hex outlineColor;
            primary = hex theme.base0B;
            primaryContainer = hex theme.base0F;
            primaryText = hex primaryText;
            secondary = hex secondaryColor;
            surface = hex theme.base01;
            surfaceContainer = hex theme.base02;
            surfaceContainerHigh = hex theme.base03;
            surfaceContainerHighest = hex theme.base04;
            surfaceText = hex textColor;
            surfaceTint = hex theme.base03;
            surfaceVariant = hex theme.base00;
            surfaceVariantText = hex textColor;
            warning = hex theme.base09;
          };
        in
        {
          xdg.config.files = {
            "DankMaterialShell/settings.json" = {
              generator = (pkgs.formats.json { }).generate "dms-settings.json";
              value = (builtins.fromJSON (builtins.readFile ./settings.json)) // {
                customThemeFile = "${userHome}/.config/DankMaterialShell/theme.json";
              };
            };
            "DankMaterialShell/theme.json" = {
              generator = (pkgs.formats.json { }).generate "dms-theme.json";
              value = {
                dark = dmsTheme;
                light = dmsTheme;
              };
            };
          };
        };
    };
}

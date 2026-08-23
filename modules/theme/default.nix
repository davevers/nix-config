{ den, self, ... }:
{
  den.aspects.theming = {
    nixos =
      { lib, pkgs, ... }:
      let
        catalog = {
          version = 1;
          default = {
            family = "rose-pine";
            mode = "light";
          };
          families = {
            rose-pine = {
              label = "Rosé Pine";
              noctalia = {
                source = "builtin";
                name = "Rosé Pine";
                wallpaper = "~/Pictures/wallpapers/rose-pine/rose_pine-01.jpg";
              };
              applications = {
                kitty = {
                  dark = "${self}/dots/kitty/themes/rose-pine/dark.conf";
                  light = "${self}/dots/kitty/themes/rose-pine/light.conf";
                  noPreference = "${self}/dots/kitty/themes/rose-pine/light.conf";
                };
                ghostty = {
                  dark = "Rose Pine";
                  light = "Rose Pine Dawn";
                };
                bat = {
                  dark = {
                    name = "Rose-Pine";
                    path = "${self}/dots/bat/themes/rose-pine/Rose-Pine.tmTheme";
                  };
                  light = {
                    name = "Rose-Pine-Dawn";
                    path = "${self}/dots/bat/themes/rose-pine/Rose-Pine-Dawn.tmTheme";
                  };
                };
                lazygit = {
                  dark = "${self}/dots/lazygit/themes/rose-pine/dark.yml";
                  light = "${self}/dots/lazygit/themes/rose-pine/light.yml";
                };
                fzf = {
                  dark = "${self}/dots/fzf/themes/rose-pine/dark.conf";
                  light = "${self}/dots/fzf/themes/rose-pine/light.conf";
                };
                fish = {
                  name = "rose-pine";
                  path = "${self}/dots/fish/themes/rose-pine/auto.theme";
                };
                niri = {
                  dark = "${self}/dots/niri/themes/rose-pine/dark.kdl";
                  light = "${self}/dots/niri/themes/rose-pine/light.kdl";
                };
              };
            };
            everforest = {
              label = "Everforest";
              noctalia = {
                source = "community";
                name = "Everforest Alt";
                wallpaper = "~/Pictures/wallpapers/everforest/everforest-abandoned_buildings_1.png";
              };
              applications = {
                kitty = {
                  dark = "${self}/dots/kitty/themes/everforest/dark.conf";
                  light = "${self}/dots/kitty/themes/everforest/light.conf";
                  noPreference = "${self}/dots/kitty/themes/everforest/light.conf";
                };
                ghostty = {
                  dark = "Everforest Dark Medium";
                  light = "Everforest Light Medium";
                };
                bat = {
                  dark = {
                    name = "Everforest Dark";
                    path = "${self}/dots/bat/themes/everforest/everforest-dark.tmTheme";
                  };
                  light = {
                    name = "Everforest Light";
                    path = "${self}/dots/bat/themes/everforest/everforest-light.tmTheme";
                  };
                };
                # lazygit = {
                #   dark = "${self}/dots/lazygit/themes/rose-pine/dark.yml";
                #   light = "${self}/dots/lazygit/themes/rose-pine/light.yml";
                # };
                fzf = {
                  dark = "${self}/dots/fzf/themes/everforest/dark.conf";
                  light = "${self}/dots/fzf/themes/everforest/light.conf";
                };
                fish = {
                  name = "rose-pine";
                  path = "${self}/dots/fish/themes/everforest/auto.theme";
                };
                niri = {
                  dark = "${self}/dots/niri/themes/everforest/dark.kdl";
                  light = "${self}/dots/niri/themes/everforest/light.kdl";
                };
              };
            };
          };
        };

        catalogFile = pkgs.writeText "theme-switch-catalog.json" (builtins.toJSON catalog);

        themeSwitch = pkgs.writeShellApplication {
          name = "theme-switch";
          runtimeInputs = with pkgs; [
            bat
            coreutils
            findutils
            fish
            fuzzel
            glib
            jq
            libnotify
            util-linux
          ];
          text = ''
            THEME_SWITCH_CATALOG_DEFAULT=${lib.escapeShellArg (toString catalogFile)}
            export GSETTINGS_SCHEMA_DIR=${lib.escapeShellArg "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas"}
            ${builtins.readFile "${self}/dots/theme-switcher/theme-switch"}
          '';
        };
      in
      {
        environment.systemPackages = [
          pkgs.fuzzel
          themeSwitch
        ];
      };
  };
}

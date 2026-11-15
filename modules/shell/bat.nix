{ self, ... }:
{
  den.aspects.shell = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.bat ];
      };

    provides.to-users = {
      hjem =
        { pkgs, ... }:
        let
          batCache = pkgs.runCommand "bat-cache" { nativeBuildInputs = [ pkgs.bat ]; } ''
            mkdir -p config "$out"
            ln -s ${self}/dots/bat config/themes
            BAT_CONFIG_DIR="$PWD/config" BAT_CACHE_PATH="$out" bat cache --build
          '';
        in
        {
          xdg.config.files = {
            "bat/config".text = ''
              --theme-dark="everforest-dark"
              --theme-light="everforest-light"
              --theme=auto
            '';
            "bat/themes/Rose-Pine-Dawn.tmTheme".source = "${self}/dots/bat/Rose-Pine-Dawn.tmTheme";
            "bat/themes/evergarden-fall.tmTheme".source = "${self}/dots/bat/evergarden-fall.tmTheme";
            "bat/themes/evergarden-summer.tmTheme".source = "${self}/dots/bat/evergarden-summer.tmTheme";
            "bat/themes/everforest-dark.tmTheme".source = "${self}/dots/bat/everforest-dark.tmTheme";
            "bat/themes/everforest-light.tmTheme".source = "${self}/dots/bat/everforest-light.tmTheme";
          };
          xdg.cache.files = {
            "bat/themes.bin".source = "${batCache}/themes.bin";
            "bat/syntaxes.bin".source = "${batCache}/syntaxes.bin";
            "bat/metadata.yaml".source = "${batCache}/metadata.yaml";
          };
        };
    };
  };
}

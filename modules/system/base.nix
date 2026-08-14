{ den, ... }:
{
  den.aspects.base = {
    includes = [
      den.batteries.hostname
    ];

    nixos =
      { pkgs, ... }:
      {
        nix = {
          settings = {
            auto-optimise-store = true;
            trusted-users = [ "@wheel" ];
            experimental-features = "nix-command flakes";
            extra-substituters = [
              "https://cache.nixos.org"
            ];
          };
          gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 30d";
          };
        };

        zramSwap = {
          enable = true;
          memoryPercent = 25;
        };

        # Set your time zone.
        time.timeZone = "Europe/Amsterdam";

        # Select internationalisation properties.
        i18n.defaultLocale = "en_US.UTF-8";

        i18n.extraLocaleSettings = {
          LC_ADDRESS = "nl_NL.UTF-8";
          LC_IDENTIFICATION = "nl_NL.UTF-8";
          LC_MEASUREMENT = "nl_NL.UTF-8";
          LC_MONETARY = "nl_NL.UTF-8";
          LC_NAME = "nl_NL.UTF-8";
          LC_NUMERIC = "nl_NL.UTF-8";
          LC_PAPER = "nl_NL.UTF-8";
          LC_TELEPHONE = "nl_NL.UTF-8";
          LC_TIME = "nl_NL.UTF-8";
        };

        environment.systemPackages = with pkgs; [
          # smartmontools
          btop
          curl
          dig
          ethtool
          git
          lm_sensors
          lsof
          tmux
          vim
          wget
        ];
      };
  };
}

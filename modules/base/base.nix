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
            experimental-features = "nix-command flakes";
          };
          gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
          };
        };
        boot = {
          loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
            systemd-boot.configurationLimit = 10;
          };
          plymouth.enable = true;
        };

        networking.networkmanager.enable = true;

        hardware.bluetooth = {
          enable = true;
          powerOnBoot = true;
        };

        hardware.enableAllFirmware = true;

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

        security.pam.services.login.enableGnomeKeyring = true;

        # services.greetd = {
        #   enable = true;
        #   settings = {
        #     initial_session = {
        #       # Starts niri session logged in automatically without prompt
        #       command = "niri-session";
        #       user = "tux";
        #     };
        #     default_session = {
        #       command = "${pkgs.tuigreet}/bin/tuigreet --remember  --asterisks  --container-padding 2 --no-xsession-wrapper --cmd niri-session";
        #     };
        #   };
        # };

        # security.pam.services.greetd.text = ''
        #   auth      substack      login
        #   account   include       login
        #   password  substack      login
        #   session   optional      ${pkgs.pam_fde_boot_pw}/lib/security/pam_fde_boot_pw.so inject_for=gkr
        #   session   include       login
        # '';
        boot.initrd.systemd.enable = true;
        services.gnome.gnome-keyring.enable = true;

        # Enable CUPS to print documents.
        services.printing.enable = true;

        # Enable sound with pipewire.
        services.pulseaudio.enable = false;
        security.rtkit.enable = true;
        services.pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
        };

        services.tuned.enable = true;
        services.upower.enable = true;

        environment.systemPackages = with pkgs; [
          git
          vim
          wget
        ];
      };
  };
}

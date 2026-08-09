{ den, ... }:
{
  flake-file.inputs = {
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.server.base =
    { host, ... }:
    {
      nixos =
        { pkgs, ... }:
        {
          users.mutableUsers = false;

          time.timeZone = "Europe/Amsterdam";

          environment.systemPackages = with pkgs; [
            btop
            curl
            dig
            ethtool
            git
            lm_sensors
            lsof
            # smartmontools
            tmux
            vim
          ];

          services.fwupd.enable = true;
          # services.smartd.enable = true;

          # boot.loader = {
          #   systemd-boot.enable = true;
          #   efi.canTouchEfiVariables = true;
          # };

          zramSwap = {
            enable = true;
            memoryPercent = 25;
          };

          nix = {
            settings = {
              auto-optimise-store = true;
              trusted-users = [ "@wheel" ];
              experimental-features = "nix-command flakes";

            };

            gc = {
              automatic = true;
              dates = "weekly";
              options = "--delete-older-than 30d";
            };
          };
        };
    };
}

{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.system-common =
    { pkgs, ... }:
    {
      imports = with self.modules.nixos; [
        services
        locale
        greetd
      ];
      nixpkgs = {
        overlays = [
          (final: _prev: {
            unstable = import inputs.nixpkgs-unstable {
              inherit (final) config;
              system = pkgs.stdenv.hostPlatform.system;
            };
          })
        ];
        config.allowUnfree = true;
      };
      system.stateVersion = "25.11";
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
      # Enable networking
      networking.networkmanager.enable = true;

      # Enable bluetooth
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };

      hardware.enableAllFirmware = true;

      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
          systemd-boot.configurationLimit = 10;
        };
        plymouth.enable = true;
      };

      environment.variables.EDITOR = "vim";
    };

}

{
  self,
  inputs,
  ...
}:
{
  flake.modules.nixos.dave =
    { pkgs, ... }:
    {
      users.users.dave = {
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
        ];
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };
      imports = [
        inputs.home-manager.nixosModules.default
      ];
      home-manager.users.dave = {
        imports = with self.modules.homeManager; [
          dave
          desktop-niri
          applications
          shell
          git
        ];
      };
    };
  flake.modules.homeManager.dave =
    { pkgs, ... }:
    {
      home = {
        username = "dave";
        homeDirectory = "/home/dave";
        stateVersion = "25.05";
      };
      systemd.user.startServices = "sd-switch";
      nixpkgs = {
        overlays = [
          (final: _prev: {
            unstable = import inputs.nixpkgs-unstable {
              inherit (final) config;
              system = pkgs.stdenv.hostPlatform.system;
            };
          })
          inputs.nur.overlays.default
        ];
        config.allowUnfree = true;
      };
      programs.git = {
        settings.user.name = "Dave Verstrate";
        settings.user.email = "daverstrate@gmail.com";
      };
    };
}

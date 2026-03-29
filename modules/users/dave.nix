{
  self,
  inputs,
  ...
}:
{
  flake.modules.nixos.dave =
    { pkgs, ... }:
    {
      imports = [
        inputs.home-manager.nixosModules.default
        self.modules.nixos.cli-tools
      ];

      home-manager.users.dave = {
        imports = with self.modules.homeManager; [
          dave
        ];
      };

      users.users.dave = {
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
        ];

        extraGroups = [
          "networkmanager"
          "wheel"
        ];

        shell = pkgs.fish;
      };
    };

  flake.modules.homeManager.dave =
    { pkgs, ... }:
    {
      imports = with self.modules.homeManager; [
        user-default
        git
        programming
      ];

      home = {
        username = "dave";
        homeDirectory = "/home/dave";
      };

      programs.git = {
        settings.user.name = "Dave Verstrate";
        settings.user.email = "daverstrate@gmail.com";
      };
    };
}

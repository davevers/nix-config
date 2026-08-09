{
  den,
  lib,
  self,
  ...
}:
{
  den.hosts.x86_64-linux.virmire.users.dave = {
  };
  den.aspects.virmire =
    { host, user, ... }:
    {
      includes = [
        den.aspects.server.base
        den.aspects.server.ssh
        den.aspects.sops
      ];

      nixos =
        { config, ... }:
        let
          secret = "users/${user.userName}/password";
        in
        {
          imports = [
            ./_hardware-configuration.nix
          ];

          boot.loader.grub.enable = true;
          boot.loader.grub.device = "/dev/vda";

          networking.hostName = "virmire";
          system.stateVersion = lib.mkDefault "26.05";
          # security.sudo.wheelNeedsPassword = false;
          sops.secrets.${secret} = {
            sopsFile = self + /secrets/common.yaml;
            neededForUsers = true;
          };
          users.users.${user.userName}.hashedPasswordFile = config.sops.secrets.${secret}.path;
          # sops.secrets."supersecret" = { };
        };
    };
}

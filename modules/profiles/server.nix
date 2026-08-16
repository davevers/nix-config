{
  den,
  self,
  ...
}:
{
  den.aspects.server = { host, user, ... }: {
    includes = [
      den.aspects.base
      den.aspects.caddy
      den.aspects.ssh
      den.aspects.sops
      den.aspects.tailscale
      den.aspects.shell
    ];

    nixos =
      let
        secret = "users/${user.userName}/password";
      in
      { config, ... }: {
        users.mutableUsers = false;
        sops.secrets.${secret} = {
          sopsFile = self + /secrets/common.yaml;
          neededForUsers = true;
        };
        users.users.${user.userName}.hashedPasswordFile = config.sops.secrets.${secret}.path;
      };
  };
}

{
  den,
  ...
}:
{
  den.aspects.server = {
    includes = [
      den.aspects.base
      den.aspects.ssh
      den.aspects.sops
      den.aspects.tailscale
      den.aspects.shell
    ];

    nixos = {
      users.mutableUsers = false;
    };
  };
}

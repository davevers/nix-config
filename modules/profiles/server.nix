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
    ];

    nixos = {
      users.mutableUsers = false;
    };
  };
}

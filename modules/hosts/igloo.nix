{ den, ... }:
{
  den.hosts.x86_64-linux.igloo.users.dave = { };

  # host aspect
  den.aspects.igloo = {
    includes = [
      den.aspects.loki-firmware
      den.aspects.base
      den.aspects.shell
    ];

    nix = { };

    # host NixOS configuration
    nixos = {
    };
  };
}

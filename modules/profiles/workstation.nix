{
  den,
  ...
}:
{
  den.aspects.workstation = {
    includes = [
      den.aspects.base
      den.aspects.audio
      den.aspects.desktop
      den.aspects.dev
      den.aspects.fonts
      den.aspects.networking
      den.aspects.power
      den.aspects.printing
      den.aspects.shell
      den.aspects.sops
      den.aspects.tailscale
      den.aspects.xdg-user-dirs
    ];

    nixos = {
      users.mutableUsers = true;
      services.udisks2.enable = true;
      services.gvfs.enable = true;
      security.polkit.enable = true;
    };
  };
}

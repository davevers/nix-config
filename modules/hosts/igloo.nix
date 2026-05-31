{ den, ... }:
{
  den.hosts.x86_64-linux.igloo.users.tux = { };

  # host aspect
  den.aspects.igloo = {
    includes = [
      den.aspects.base
      den.aspects.desktop
      den.aspects.shell
    ];

    nix = { };

    # host NixOS configuration
    nixos =
      { pkgs, ... }:
      {
        local.dms.greeterUser = "tux";

        virtualisation.vmVariant = {
          virtualisation = {
            graphics = true;

            qemu.options = [
              "-vga none"
              "-device virtio-gpu-gl"
              "-display sdl,gl=on"
            ];
          };
        };
        hardware.graphics.enable = true;
      };
  };
}

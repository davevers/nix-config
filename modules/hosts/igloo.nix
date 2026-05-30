{ den, ... }:
{
  den.hosts.x86_64-linux.igloo.users.tux = { };

  # host aspect
  den.aspects.igloo = {
    includes = [
      (den.batteries.unfree [
        "broadcom-bt-firmware"
        "b43-firmware"
        "xone-dongle-firmware"
        "facetimehd-calibration"
        "facetimehd-firmware"
      ])
      den.aspects.base
      den.aspects.desktop
      den.aspects.shell
    ];

    nix = { };

    # host NixOS configuration
    nixos =
      { pkgs, ... }:
      {
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

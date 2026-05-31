{ den, ... }:
{
  den.hosts.x86_64-linux.loki.users.dave = { };

  # host aspect
  den.aspects.loki = {
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
      den.aspects.dev
    ];

    # host NixOS configuration
    nixos = {
      boot = {
        extraModprobeConfig = ''
          options snd-hda-intel dmic_detect=0
          options snd-intel-dspcfg dsp_driver=1
        '';
        initrd.luks.devices."luks-4d3dca95-cccf-48da-b970-cae48ccecfd9".device =
          "/dev/disk/by-uuid/4d3dca95-cccf-48da-b970-cae48ccecfd9";
      };

      nix.settings = {
        trusted-users = [ "dave" ];
        extra-substituters = [
          "https://cache.nixos.org"
          "https://cache.numtide.com"
        ];
        extra-trusted-public-keys = [
          "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        ];
      };
    };
  };
}

{ den, inputs, ... }:
{
  den.hosts.x86_64-linux.loki.users.dave = {
  };

  den.aspects.loki-firmware = {
    includes = [
      (den.batteries.unfree [
        "broadcom-bt-firmware"
        "b43-firmware"
        "xone-dongle-firmware"
        "facetimehd-calibration"
        "facetimehd-firmware"
      ])
    ];
    nixos = {
      hardware.enableAllFirmware = true;
    };
  };

  # host aspect
  den.aspects.loki = {
    includes = [
      den.aspects.loki-firmware
      den.aspects.workstation
    ];

    # host NixOS configuration
    nixos = {
      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
          systemd-boot.configurationLimit = 10;
        };
        plymouth.enable = true;
        extraModprobeConfig = ''
          options snd-hda-intel dmic_detect=0
          options snd-intel-dspcfg dsp_driver=1
        '';
        initrd.luks.devices."luks-4d3dca95-cccf-48da-b970-cae48ccecfd9".device =
          "/dev/disk/by-uuid/4d3dca95-cccf-48da-b970-cae48ccecfd9";
        initrd.systemd.enable = true;
      };
    };
  };
}

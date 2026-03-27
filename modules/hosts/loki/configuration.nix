# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  self,
  ...
}:
{
  flake.modules.nixos.loki = {
    imports = with self.modules.nixos; [
      system-common
      dave
    ];
    networking.hostName = "loki";
    boot = {
      extraModprobeConfig = ''
        options snd-hda-intel dmic_detect=0
        options snd-intel-dspcfg dsp_driver=1
      '';
      initrd.luks.devices."luks-4d3dca95-cccf-48da-b970-cae48ccecfd9".device =
        "/dev/disk/by-uuid/4d3dca95-cccf-48da-b970-cae48ccecfd9";
    };
  };
}

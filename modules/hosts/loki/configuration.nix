{ self, inputs, ... }:
{
  flake.nixosConfigurations.loki = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.loki
    ];
  };

  flake.modules.nixos.loki = {
    imports = with self.modules.nixos; [
      system-default
      stylix
      greetd
      dave
    ];

    home-manager.users.dave = {
      imports = with self.modules.homeManager; [
        niri
        common-applications
        vscode
        neovim
      ];
    };

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

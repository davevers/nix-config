{
  inputs,
  self,
  ...
}:
{
  # Host-level sops setup
  den.aspects.networking =
    { host, ... }:
    {
      nixos = {
        networking.networkmanager = {
          enable = true;
          wifi = {
            backend = "iwd";
            powersave = false;
          };
        };
        networking.wireless.iwd.enable = true;
        hardware.bluetooth = {
          enable = true;
          powerOnBoot = true;
        };
      };
    };
}

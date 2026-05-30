{ lib, den, ... }:
{
  den.default.nixos.system.stateVersion = "25.11";

  # enable hjem by default
  den.schema.user.classes = lib.mkDefault [ "hjem" ];
}

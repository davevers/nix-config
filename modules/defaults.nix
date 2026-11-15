{ lib, ... }:
{
  den.schema.user = {
    classes = lib.mkDefault [
      "hjem"
    ];
  };
}

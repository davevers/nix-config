{ den, ... }:
{
  # user aspect
  den.aspects.tux = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      (den.batteries.user-shell "fish")
      { nixos.security.sudo.wheelNeedsPassword = false; }
    ];
  };
}

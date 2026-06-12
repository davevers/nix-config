{ den, ... }:
{
  # user aspect
  den.aspects.dave = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      (den.batteries.user-shell "fish")
      den.aspects.stylix
    ];
  };
}

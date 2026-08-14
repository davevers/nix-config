{
  den.aspects.power = {
    nixos = {
      services.tuned.enable = true;
      services.upower.enable = true;
    };
  };
}

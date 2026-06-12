{
  den.aspects.desktop =
    { host, user, ... }:
    {
      homeManager =
        { lib, ... }:
        {
          dconf.settings."org/gnome/desktop/interface".color-scheme = lib.mkForce "prefer-dark";
        };
    };
}

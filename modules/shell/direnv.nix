{
  den.aspects.shell =
    { host, user, ... }:
    {
      nixos = {
        programs.direnv = {
          enable = true;
          settings.global.hide_env_diff = true;
        };
      };
    };
}

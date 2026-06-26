{
  den.aspects.shell = {
    nixos = {
      programs.direnv = {
        enable = true;
        settings.global.hide_env_diff = true;
      };
    };
  };
}

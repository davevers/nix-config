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
      homeManager = {
        programs = {
          direnv = {
            enable = true;
            # enableFishIntegration = true;
            nix-direnv.enable = true;
            config = {
              global.hide_env_diff = true;
            };
          };
        };
      };
    };
}

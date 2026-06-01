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
      # hjem =
      #   { pkgs, ... }:
      #   {
      #     xdg.config.files = {
      #       "direnv/direnv.toml" = {
      #         generator = (pkgs.formats.toml { }).generate "direnv.toml";
      #         value = {
      #           global.hide_env_diff = true;
      #         };
      #       };
      #     };
      #   };
    };
}

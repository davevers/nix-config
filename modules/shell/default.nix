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

          fzf = {
            enable = true;
          };

          ripgrep = {
            enable = true;
          };

          zoxide = {
            enable = true;
          };

          bat = {
            enable = true;
          };

          eza = {
            enable = true;
          };

          fd = {
            enable = true;
          };

          # nix-your-shell = {
          #   enable = true;
          # };
        };
      };
    };
}

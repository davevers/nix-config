{
  den.aspects.shell =
    { host, user, ... }:
    {
      nixos =
        { pkgs, ... }:
        {
          programs.fish = {
            enable = true;
            vendor = {
              completions.enable = true;
              config.enable = true;
              functions.enable = true;
            };
          };
        };

      homeManager =
        { pkgs, ... }:
        {
          home.packages = with pkgs; [
            fishPlugins.pure
            fishPlugins.sponge
            fishPlugins.fzf
          ];
          programs.fish = {
            enable = true;
            interactiveShellInit = ''
              set fish_greeting # Disable greeting
            '';
          };
        };
    };
}

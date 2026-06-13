{
  den.aspects.dev =
    { user, ... }:
    {
      homeManager = {
        programs.lazygit = {
          enable = true;
          settings = {
            gui = {
              nerdFontsVersion = "3";
              showIcons = true;
            };
          };
        };
      };
    };
}

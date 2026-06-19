{
  den.aspects.dev = {
    nixos = {
      programs.lazygit = {
        enable = true;
        settings = {
          gui = {
            nerdFontsVersion = "3";
          };
        };
      };
    };
  };
}

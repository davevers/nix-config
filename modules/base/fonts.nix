{ den, ... }:
{
  den.aspects.base = {
    nixos =
      { pkgs, ... }:
      {
        fonts = {
          packages = with pkgs; [
            lilex
            adwaita-fonts
            noto-fonts
          ];

          fontconfig = {
            defaultFonts = {
              serif = [ "Noto Serif" ];
              sansSerif = [ "Adwaita Sans" ];
              monospace = [ "Lilex" ];
            };
          };
        };
      };
  };
}

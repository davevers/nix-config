{
  den.aspects.desktop =
    { user, ... }:
    {
      hjem =
        { config, pkgs, ... }:
        let
          theme = config.local.theme.base16;
          rgba = theme.helpers.rgba;
        in
        {
          packages = [
            pkgs.fuzzel
          ];
          xdg.config.files = {
            "fuzzel/fuzzel.ini".text = ''
              font=Lilex:size=14, Noto Color Emoji
              dpi-aware=no
              fields=name,generic,comment,categories,filename,keywords
              terminal=kitty

              [border]
              width=2

              [colors]
              background=${rgba theme.base00 "ff"}
              text=${rgba theme.base06 "ff"}
              prompt=${rgba theme.base06 "ff"}
              placeholder=${rgba theme.base04 "ff"}
              input=${rgba theme.base06 "ff"}
              match=${rgba theme.base0A "ff"}
              selection=${rgba theme.base04 "ff"}
              selection-text=${rgba theme.base06 "ff"}
              selection-match=${rgba theme.base0A "ff"}
              counter=${rgba theme.base07 "ff"}
              border=${rgba theme.base0D "ff"}
            '';
          };
        };
    };
}

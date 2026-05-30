{
  den.aspects.desktop =
    { user, ... }:
    {
      hjem =
        { pkgs, ... }:
        {
          packages = [
            pkgs.fuzzel
          ];
          xdg.config.files = {
            "fuzzel/fuzzel.ini".text = ''
              font=Lilex:size=14, Noto Color Emoji
              fields=name,generic,comment,categories,filename,keywords
              terminal=kitty

              [border]
              width=2

              [colors]
              background=272e33ff
              text=d3c6aaff
              prompt=d3c6aaff
              placeholder=859289ff
              input=d3c6aaff
              match=dbbc7fff
              selection=414b50ff
              selection-text=d3c6aaff
              selection-match=dbbc7fff
              counter=edeadaff
              border=7fbbb3ff
            '';
          };
        };
    };
}

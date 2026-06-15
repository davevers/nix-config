{
  den.aspects.desktop =
    { host, user, ... }:
    {
      homeManager = {
        programs.kitty = {
          enable = true;
          settings = {
            # symbol_map =
            #   let
            #     mappings = [
            #       "U+25B6"
            #       "U+25BC"
            #     ];
            #   in
            #   (builtins.concatStringsSep "," mappings) + " DejaVu Sans Mono";
          };
        };
      };
    };
}

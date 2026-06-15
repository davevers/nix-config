{
  den.aspects.base = {
    nixos =
      { lib, pkgs, ... }:
      {
        fonts.packages = with pkgs; [
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-color-emoji
          dejavu_fonts
          nerd-fonts.symbols-only
        ];

        fonts.fontconfig.defaultFonts = {
          sansSerif = lib.mkAfter [
            "Noto Sans CJK JP"
            "Noto Color Emoji"
          ];

          serif = lib.mkAfter [
            "Noto Serif CJK JP"
          ];

          monospace = lib.mkAfter [
            "DejaVu Sans Mono"
            "Symbols Nerd Font Mono"
          ];

          emoji = lib.mkAfter [
            "Noto Color Emoji"
          ];
        };
      };
  };
}

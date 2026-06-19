{
  den.aspects.fonts = {
    nixos =
      { lib, pkgs, ... }:
      {
        fonts.packages = with pkgs; [
          adwaita-fonts
          lilex
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-color-emoji
          dejavu_fonts
          nerd-fonts.symbols-only
        ];

        fonts.fontconfig.defaultFonts = {
          sansSerif = lib.mkAfter [
            "Adwaita Sans"
            "Noto Sans CJK JP"
          ];

          serif = lib.mkAfter [
            "Noto Serif"
            "Noto Serif CJK JP"
          ];

          monospace = lib.mkAfter [
            "Lilex"
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

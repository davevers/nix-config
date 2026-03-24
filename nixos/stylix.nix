{
  pkgs,
  ...
}:

{
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    polarity = "dark";

    opacity = {
      applications = 0.9;
      terminal = 0.9;
      popups = 0.9;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.lilex;
        name = "Lilex Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.adwaita-fonts;
        name = "Adwaita Sans";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };

      sizes = {
        applications = 12;
        desktop = 12;
        terminal = 15;
        popups = 15;
      };
    };
  };
}

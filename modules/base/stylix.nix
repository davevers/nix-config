{ inputs, ... }:
{
  flake-file.inputs = {
    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.stylix =
    { host, user, ... }:
    {
      nixos =
        { pkgs, lib, ... }:
        {
          imports = [
            inputs.stylix.nixosModules.stylix
          ];
          stylix = {
            enable = true;
            autoEnable = true;
            polarity = "dark";
            base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

            cursor = {
              package = pkgs.bibata-cursors;
              name = "Bibata-Modern-Classic";
              size = 24;
            };

            icons = {
              enable = true;
              package = pkgs.papirus-icon-theme;
              light = "Papirus";
              dark = "Papirus-Dark";
            };

            fonts = {
              monospace = {
                package = pkgs.lilex;
                name = "Lilex";
              };
              sansSerif = {
                package = pkgs.adwaita-fonts;
                name = "Adwaita Sans";
              };
              serif = {
                package = pkgs.noto-fonts;
                name = "Noto Serif";
              };

              emoji = {
                package = pkgs.noto-fonts-color-emoji;
                name = "Noto Color Emoji";
              };

              sizes = {
                applications = 12;
                desktop = 12;
                terminal = 15;
                popups = 15;
              };
            };
          };
        };
    };
}

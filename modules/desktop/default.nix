{ den, ... }:
{
  den.aspects.desktop = {
    includes = with den.aspects; [
      firefox
      ghostty
      greeterd
      helium
      kitty
      niri
      noctalia
      obsidian
      vscodium
      zed
    ];

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          seahorse
          nautilus
          papirus-icon-theme
        ];
      };

    provides.to-users = {
      hjem = {
        files =
          let
            gtkSettings = ''
              [Settings]
              gtk-font-name=Adwaita Sans 16
              gtk-icon-theme-name=Papirus
            '';
          in
          {
            ".config/gtk-3.0/settings.ini".text = gtkSettings;
            ".config/gtk-4.0/settings.ini".text = gtkSettings;
          };
      };
    };
  };
}

{ den, ... }:
{
  den.aspects.desktop = {
    includes = with den.aspects; [
      firefox
      ghostty
      greeterd
      flatpak
      kitty
      niri
      noctalia
      proton
      obsidian
      vscodium
      whatsapp
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

        programs.dconf = {
          enable = true;

          profiles.user.databases = [
            {
              settings."org/gnome/desktop/interface" = {
                font-name = "Adwaita Sans 11";
                monospace-font-name = "Lilex 12";
                color-scheme = "prefer-light";
                gtk-theme = "Adwaita";
              };
            }
          ];
        };
      };

    provides.to-users = {
      hjem = {
        files =
          let
            gtkSettings = ''
              [Settings]
              gtk-font-name=Adwaita Sans 11
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

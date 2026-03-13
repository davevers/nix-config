{ config, pkgs, inputs, ...}: {
  programs.firefox = {
    enable = true;
    profiles.${config.home.username} = {
      id = 0;
      isDefault = true;
      settings = {
      };
      search = {
        force = true;
        default = "Kagi";
        order = [
          "Kagi"
          "nix-packages"
          "nixos-wiki"
          "ddg"
        ];
        engines = {
          nix-packages = {
            name = "Nix Packages";
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          nixos-wiki = {
            name = "NixOS Wiki";
            urls = [{ template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; }];
            iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
            definedAliases = [ "@nw" ];
          };

          Kagi = {
            urls = [
              { template = "https://kagi.com/search?q={searchTerms}"; }
            ];
            # icon = "https://kagi.com/favicon.ico";
            icon = "https://assets.kagi.com/v2/favicon-32x32.png";
            definedAliases = [
              "@kg"
              "@kagi"
            ];
          };
        };
      };
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        privacy-badger
        proton-pass
        web-clipper-obsidian
        kagi-search
        kagi-translate
      ];
    };
  };
}

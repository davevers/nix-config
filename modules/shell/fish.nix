{ self, ... }:
{
  den.aspects.shell = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs.fishPlugins; [
          fzf-fish
          sponge
          hydro
        ];
        programs.fish = {
          enable = true;
          shellAbbrs = {
            # nix stuff
            nsh = "nix shell nixpkgs#";
            nrn = "nix run nixpkgs#";
            nrs = "nix run .#$hostname -- switch";
            nrsd = "nix run .#$hostname -- switch --dry";
          };
          shellAliases = {
            ls = "eza --icons --group-directories-first -1";
          };
          interactiveShellInit = ''
            set sponge_purge_only_on_exit true
            set fish_greeting
            set fish_cursor_insert line blink
            fish_config theme choose "Evergarden Auto"
            set -Ux FZF_DEFAULT_OPTS '--color=base16'
          '';
        };
      };

    provides.to-users = {
      hjem = {
        xdg.config.files = {
          "fish/themes/Rosé Pine Auto.theme".source = "${self}/dots/fish/Rosé Pine Auto.theme";
          "fish/themes/Evergarden Auto.theme".source = "${self}/dots/fish/Evergarden Auto.theme";
        };
      };
    };
  };
}

{ self, ... }:
{
  den.aspects.shell =
    { host, user, ... }:
    {
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
              fish_config theme choose "Rosé Pine Auto"
              set -Ux FZF_DEFAULT_OPTS "
              	--color=fg:#797593,bg:#faf4ed,hl:#d7827e
              	--color=fg+:#575279,bg+:#f2e9e1,hl+:#d7827e
              	--color=border:#dfdad9,header:#286983,gutter:#faf4ed
              	--color=spinner:#ea9d34,info:#56949f
              	--color=pointer:#907aa9,marker:#b4637a,prompt:#797593"
            '';
          };
        };

      hjem = {
        xdg.config.files = {
          "fish/themes/Rosé Pine Auto.theme".source = "${self}/dots/fish/Rosé Pine Auto.theme";
        };
      };
    };
}

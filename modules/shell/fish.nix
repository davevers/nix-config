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
            set -eU FZF_DEFAULT_OPTS
            set -q XDG_STATE_HOME; or set -l XDG_STATE_HOME "$HOME/.local/state"
            set -gx FZF_DEFAULT_OPTS_FILE "$XDG_STATE_HOME/theme-switcher/fzf.conf"
          '';
        };
      };

  };
}

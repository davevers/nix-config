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
            fish_config theme choose "evergarden-auto"
            set -Ux FZF_DEFAULT_OPTS '--color=base16'
            function sys_color_scheme_is_dark
                string match -q '*prefer-dark*' (dconf read /org/gnome/desktop/interface/color-scheme)
            end
            if sys_color_scheme_is_dark
                set -U fzf_preview_file_cmd bat --color=always --style=numbers --theme=evergarden-fall
            else
                set -U fzf_preview_file_cmd bat --color=always --style=numbers --theme=evergarden-summer
            end
          '';
        };
      };

    provides.to-users = {
      hjem = {
        xdg.config.files = {
          "fish/themes/rose-pine-auto.theme".source = "${self}/dots/fish/rose-pine-auto.theme";
          "fish/themes/evergarden-auto.theme".source = "${self}/dots/fish/evergarden-auto.theme";
        };
      };
    };
  };
}

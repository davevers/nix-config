{
  den.aspects.shell =
    { host, user, ... }:
    {
      nixos = {
        programs.fish.enable = true;
      };
      hjem =
        { pkgs, ... }:
        {
          packages = with pkgs; [
            fishPlugins.pure
            fishPlugins.sponge
            fishPlugins.fzf-fish
          ];
          xdg.config.files = {
            "fish/config.fish".text = ''
              if status is-interactive
                  # Commands to run in interactive sessions can go here
              end

              set -g fish_greeting
              set -g fish_handle_reflow 0

              # Keybinds
              bind \cy accept-autosuggestion

              # Pure
              if type -q kubectl
                set -g pure_enable_k8s true
                set -g pure_symbol_k8s_prefix 󱃾
              end

              # Abbrevations
              # general
              abbr --add dotdot --regex '^\.\.+$' --function multicd
              # ls
              abbr -a -- l ll -a
              abbr -a -- lr ll -T
              abbr -a -- lx ll -sextension
              abbr -a -- lk ll -ssize
              abbr -a -- lt ll -smodified
              abbr -a -- lc ll -schanged
              # chezmoi
              abbr -a cma chezmoi add
              abbr -a cme chezmoi edit -a
              abbr -a cmd chezmoi diff
              abbr -a cms chezmoi status
              #git
              abbr -a lg lazygit

              if command -q nix-your-shell
                nix-your-shell fish | source
              end

              if command -q zoxide
                zoxide init fish | source
              end
            '';
          };
        };
    };
}

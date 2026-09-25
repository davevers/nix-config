{
  den.aspects.shell = {
    nixos =
      { pkgs, ... }:
      {
        programs = {
          zoxide.enable = true;
        };
        environment.systemPackages = with pkgs; [
          btop
          cbonsai
          fastfetch
          fzf
          ripgrep
          eza
          fd
          # nix-your-shell
        ];
      };
  };
}

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
          hledger
          ripgrep
          eza
          fd
          # nix-your-shell
        ];
      };
  };
}

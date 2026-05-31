{
  den.aspects.shell =
    { host, user, ... }:
    {
      nixos = {
        programs.direnv = {
          enable = true;
        };
      };
  hjem =
    { pkgs, ... }:
    {
      packages = with pkgs; [
        fzf
        zoxide
        ripgrep
        bat
        eza
        fd
        nix-your-shell
      ];
    };
    };
}

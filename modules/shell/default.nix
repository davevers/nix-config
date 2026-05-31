{
  den.aspects.shell =
    { host, user, ... }:
    {
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

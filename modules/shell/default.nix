{
  den.aspects.shell =
    { user, ... }:
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
          ];
        };
    };
}

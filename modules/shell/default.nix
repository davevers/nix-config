{
  den.aspects.shell =
    { host, user }:
    {
      nixos =
        { pkgs, ... }:
        {
          programs = {
            zoxide.enable = true;
          };
          environment.systemPackages = with pkgs; [
            btop
            cbonsai
            fzf
            ripgrep
            eza
            fd
            # nix-your-shell
          ];
        };
    };
}

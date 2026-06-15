{
  den.aspects.shell =
    { host, user, ... }:
    {
      homeManager =
        { pkgs, ... }:
        {
          programs = {
            fzf.enable = true;
            ripgrep.enable = true;
            zoxide.enable = true;
            bat.enable = true;
            eza.enable = true;
            fd.enable = true;
            fastfetch.enable = true;
            btop.enable = true;
          };
          home.packages = with pkgs; [
            cbonsai
          ];
        };
    };
}

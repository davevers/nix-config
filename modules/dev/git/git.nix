{
  den.aspects.dev =
    { host, user, ... }:
    {
      nixos = {
        programs.git.enable = true;
      };

      hjem = {
        xdg.config.files = {
          "git/config".text = ''
            [credential]
                helper = libsecret
            [credential "https://github.com"]
                helper=
                helper=!gh auth git-credential
            [credential "https://gist.github.com"]
                helper=
                helper=!gh auth git-credential
            [user]
                email=daverstrate@gmail.com
                name=Dave Verstrate
          '';
        };
      };
    };
}

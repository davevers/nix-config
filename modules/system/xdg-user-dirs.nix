{
  den.aspects.xdg-user-dirs = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.xdg-user-dirs
        ];

        systemd.packages = [
          pkgs.xdg-user-dirs.lib
        ];

        systemd.user.targets.default.wants = [
          "xdg-user-dirs.service"
        ];
      };
  };
}

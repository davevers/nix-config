{
  self,
  ...
}:
{

  flake.modules.nixos.cli-tools =
    { pkgs, ... }:
    {
      imports = with self.modules.nixos; [
        shell
      ];
      home-manager.sharedModules = [
        self.modules.homeManager.cli-tools
      ];

      environment.systemPackages = with pkgs; [
        git
        vim
        curl
        wget
      ];
    };

  flake.modules.homeManager.cli-tools =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        fastfetch
      ];

      programs.zoxide = {
        enable = true;
      };

      programs.fzf = {
        enable = true;
      };

      programs.bat = {
        enable = true;
      };

      programs.ripgrep = {
        enable = true;
      };

      programs.eza = {
        enable = true;
      };

      programs.fd = {
        enable = true;
      };

      programs.yazi = {
        enable = true;
      };
    };
}

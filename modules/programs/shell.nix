{

  flake.modules.nixos.shell =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        git
        vim
        curl
        wget
      ];
    };
  flake.modules.homeManager.shell =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        fishPlugins.pure
        fishPlugins.sponge
        fishPlugins.fzf
      ];

      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting # Disable greeting
        '';
      };

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
    };
}

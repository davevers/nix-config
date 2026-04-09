{
  self,
  ...
}:
{

  flake.modules.nixos.shell = {
    home-manager.sharedModules = [
      self.modules.homeManager.shell
    ];

    programs.fish = {
      enable = true;
      vendor = {
        completions.enable = true;
        config.enable = true;
        functions.enable = true;
      };
    };
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
    };
}

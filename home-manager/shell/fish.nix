{
  pkgs,
  ...
}:
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
}

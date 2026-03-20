{
  pkgs,
  ...
}:
{
  programs.fish = {
    enable = true;
    plugins = with pkgs; [
      fishPlugins.pure
      fishPlugins.sponge
      fishPlugins.fzf
    ];
    interactiveShellInit = ''
      set fish_greeting
    '';
  };
}

{
  config,
  ...
}:
{
  programs.fuzzel = {
    enable = true;
  };

  stylix.targets.fuzzel.fonts.override = {
    sansSerif = config.stylix.fonts.monospace;
  };
  stylix.targets.fuzzel.colors.override = {
    base0D-hex = config.lib.stylix.colors.base05-hex;
  };
}

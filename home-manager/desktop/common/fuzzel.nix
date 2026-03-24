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
}

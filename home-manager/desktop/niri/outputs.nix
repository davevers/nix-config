{
  pkgs,
  ...
}:

{
  programs.niri.settings.outputs = {
    "DP-1" = {
      mode = {
        width = 3440;
        height = 1440;
        refresh = 59.973;
      };
      scale = 1.0;
      position = {
        x = 0;
        y = 0;
      };
    };
    "eDP-1" = {
      mode = {
        width = 3840;
        height = 2160;
        refresh = 60.006;
      };
      scale = 2.0;
      position = {
        x = 3440;
        y = 360;
      };
    };
  };
}

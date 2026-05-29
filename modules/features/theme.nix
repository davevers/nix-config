{ ... }:
let
  theme = {
    base00 = "#272e33";
    base01 = "#2e383c";
    base02 = "#414b50";
    base03 = "#859289";
    base04 = "#9da9a0";
    base05 = "#d3c6aa";
    base06 = "#edeada";
    base07 = "#fffbef";
    base08 = "#e67e80";
    base09 = "#e69875";
    base0A = "#dbbc7f";
    base0B = "#a7c080";
    base0C = "#83c092";
    base0D = "#7fbbb3";
    base0E = "#d699b6";
    base0F = "#9da9a0";
  };
  stripHash =
    str:
    if builtins.substring 0 1 str == "#" then
      builtins.substring 1 (builtins.stringLength str - 1) str
    else
      str;

  themeNoHash = builtins.mapAttrs (_: v: stripHash v) theme;
in
{
  flake = {
    inherit theme themeNoHash;
  };
}

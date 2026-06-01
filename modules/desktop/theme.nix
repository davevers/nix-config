{ lib, ... }:
let
  catalog = {
    everforest-dark-hard = {
      variant = "dark";
      palette = {
        base00 = "272e33";
        base01 = "1e2326";
        base02 = "2e383c";
        base03 = "374145";
        base04 = "859289";
        base05 = "9da9a0";
        base06 = "d3c6aa";
        base07 = "edeada";
        base08 = "e67e80";
        base09 = "e69875";
        base0A = "dbbc7f";
        base0B = "a7c080";
        base0C = "83c092";
        base0D = "7fbbb3";
        base0E = "d699b6";
        base0F = "6c8446";
      };
    };

    everforest-light-hard = {
      variant = "light";
      palette = {
        base00 = "fffbef";
        base01 = "f2efdf";
        base02 = "edeada";
        base03 = "e8e5d5";
        base04 = "829181";
        base05 = "5c6a72";
        base06 = "939f91";
        base07 = "a6b0a0";
        base08 = "f85552";
        base09 = "f57d26";
        base0A = "dfa000";
        base0B = "8da101";
        base0C = "35a77c";
        base0D = "3a94c5";
        base0E = "df69ba";
        base0F = "92b259";
      };
    };
  };
  baseKeys = [
    "base00"
    "base01"
    "base02"
    "base03"
    "base04"
    "base05"
    "base06"
    "base07"
    "base08"
    "base09"
    "base0A"
    "base0B"
    "base0C"
    "base0D"
    "base0E"
    "base0F"
  ];

  mkColorOption =
    name:
    lib.nameValuePair name (
      lib.mkOption {
        type = lib.types.strMatching "[0-9a-fA-F]{6}";
        readOnly = true;
        description = "Resolved Base16 color ${name} without a leading #.";
      }
    );

  mkThemeModule =
    defaultScheme:
    { config, ... }:
    let
      schemeName = config.local.theme.base16.scheme;
      entry =
        catalog.${schemeName} or (throw ''
          Unknown Base16 scheme "${schemeName}".
          Available schemes: ${lib.concatStringsSep ", " (builtins.attrNames catalog)}
        '');
      palette = entry.palette;
      hex = color: "#${color}";
      rgba = color: alpha: "${color}${alpha}";
    in
    {
      options.local.theme.base16 = {
        scheme = lib.mkOption {
          type = lib.types.str;
          default = defaultScheme;
          example = "everforest-light-hard";
          description = "Named Base16 scheme selected from the local theme catalog.";
        };

        variant = lib.mkOption {
          type = lib.types.enum [
            "dark"
            "light"
          ];
          readOnly = true;
          description = "Variant metadata for the selected Base16 scheme.";
        };

        palette = lib.mkOption {
          type = lib.types.attrsOf (lib.types.strMatching "[0-9a-fA-F]{6}");
          readOnly = true;
          description = "Resolved Base16 palette for the selected scheme.";
        };

        helpers = lib.mkOption {
          type = lib.types.anything;
          readOnly = true;
          internal = true;
          description = "Shared helpers for formatting theme colors.";
        };
      }
      // builtins.listToAttrs (map mkColorOption baseKeys);

      config.local.theme.base16 = {
        variant = entry.variant;
        inherit palette;
        helpers = {
          inherit hex rgba;
        };
      }
      // builtins.listToAttrs (map (name: lib.nameValuePair name palette.${name}) baseKeys);
    };
in
{
  den.aspects.desktop =
    { host, user, ... }:
    let
      userThemeScheme =
        if builtins.isAttrs user && user ? theme && user.theme ? base16 && user.theme.base16 ? scheme then
          user.theme.base16.scheme
        else
          "everforest-dark-hard";
    in
    {
      nixos = mkThemeModule userThemeScheme;
      hjem = mkThemeModule userThemeScheme;
    };
}

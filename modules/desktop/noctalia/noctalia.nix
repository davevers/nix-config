{ inputs, ... }:
{
  flake-file.inputs = {
    noctalia = {
      url = "github:noctalia-dev/noctalia";
    };
  };
  flake-file.nixConfig = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
  den.aspects.desktop =
    { host, user, ... }:
    {
      nixos =
        { pkgs, ... }:
        {
          environment.systemPackages = [
            inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
          ];
        };
      homeManager =
        { config, ... }:
        {
          imports = [ inputs.noctalia.homeModules.default ];
          programs.noctalia = {
            enable = true;
            settings = {
              theme = {
                source = "custom";
              };
            };
            customPalettes = {
              colors = with config.lib.stylix.colors.withHashtag; {
                dark = {
                  mPrimary = base0D;
                  mOnPrimary = base00;
                  mSecondary = base0E;
                  mOnSecondary = base00;
                  mTertiary = base0C;
                  mOnTertiary = base00;
                  mError = base08;
                  mOnError = base00;
                  mSurface = base00;
                  mOnSurface = base05;
                  mHover = base0C;
                  mOnHover = base00;
                  mSurfaceVariant = base01;
                  mOnSurfaceVariant = base04;
                  mOutline = base03;
                  mShadow = base00;
                  terminal = { };
                };
              };
            };
          };
        };
    };
}

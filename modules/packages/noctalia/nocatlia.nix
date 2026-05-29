{ self, inputs, ... }:
{
  perSystem =
    { pkgs, unstable, ... }:
    {
      packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
        inherit pkgs;
        package = pkgs.unstable.noctalia-shell;
        settings = (builtins.fromJSON (builtins.readFile ./noctalia.json)).settings;
        colors = with self.theme; {
          mPrimary = base05;
          mOnPrimary = base00;
          mSecondary = base05;
          mOnSecondary = base00;
          mTertiary = base04;
          mOnTertiary = base00;
          mError = base08;
          mOnError = base00;
          mSurface = base00;
          mOnSurface = base05;
          mHover = base04;
          mOnHover = base00;
          mSurfaceVariant = base01;
          mOnSurfaceVariant = base04;
          mOutline = base02;
          mShadow = base00;
        };
      };
    };
}

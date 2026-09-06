{ config, ... }:

let
  c = config.theme.colors;
in
{
  programs.noctalia-shell = {
    colors = {
      mPrimary = c.yellowBright;
      mOnPrimary = c.bg;

      mSecondary = c.purple;
      mOnSecondary = c.bg;

      mTertiary = c.greenBright;
      mOnTertiary = c.bg;

      mError = c.redBright;
      mOnError = c.bg;

      mSurface = c.bg;
      mOnSurface = c.fg;

      mSurfaceVariant = c.bgAlt;
      mOnSurfaceVariant = c.gray;

      mOutline = c.bgAlt;
      mShadow = c.black;

      mHover = c.fg;
      mOnHover = c.bg;
    };

    settings.colorSchemes = {
      useWallpaperColors = false;
      predefinedScheme = "";
      darkMode = true;
    };
  };
}

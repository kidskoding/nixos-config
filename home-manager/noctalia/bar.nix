{ ... }:

{
  programs.noctalia-shell.settings.bar = {
    position = "top";
    barType = "floating";
    marginVertical = 6;
    marginHorizontal = 8;
    contentPadding = 8;
    widgetSpacing = 8;
    useSeparateOpacity = true;
    backgroundOpacity = 0.85;
    rightClickAction = "none";

    widgets = {
      left = [
        {
          id = "Workspace";
          labelMode = "index";
          emptyColor = "none";
          hideUnoccupied = true;
        }
      ];
      center = [
        {
          id = "MediaMini";
          maxWidth = 300;
          scrollingMode = "always";
          useFixedWidth = false;
        }
      ];
      right = [
        { id = "Tray"; }
        { id = "Volume"; displayMode = "alwaysShow"; }
        { id = "Network"; displayMode = "alwaysShow"; }
        { id = "Brightness"; displayMode = "alwaysShow"; }
        { id = "Battery"; displayMode = "icon-always"; }
        {
          id = "Clock";
          formatHorizontal = "ddd MMM dd  hh:mm AP";
          tooltipFormat = "dddd, MMMM d yyyy";
        }
        { id = "ControlCenter"; }
      ];
    };
  };
}

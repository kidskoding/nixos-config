{ ... }:

{
  programs.noctalia-shell.settings.notifications = {
    location = "top_right";
    density = "compact";
    lowUrgencyDuration = 10;
    normalUrgencyDuration = 10;
    criticalUrgencyDuration = 60;
  };
}

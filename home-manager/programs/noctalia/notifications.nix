{ ... }:

{
  programs.noctalia-shell.settings.notifications = {
    location = "top_right";
    density = "compact";
    lowUrgencyDuration = 5;
    normalUrgencyDuration = 5;
    criticalUrgencyDuration = 10;
  };
}

{...}: {
  flake.homeModules.kidskoding = {pkgs, ...}: {
    home.packages = with pkgs; [
      claude-agent-acp
      codex-acp
    ];
  };
}

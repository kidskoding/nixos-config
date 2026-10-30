{...}: {
  flake.homeModules.agents = {pkgs, ...}: {
    home.packages = with pkgs; [
      claude-agent-acp
      codex-acp
    ];
  };
}

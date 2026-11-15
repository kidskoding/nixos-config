{inputs, ...}: {
  flake.homeModules.agents = {pkgs, ...}: {
    home.packages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
      claude-agent-acp
      codex-acp
    ];
  };
}

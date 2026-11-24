{inputs, ...}: {
  flake.homeModules.agents = {pkgs, ...}: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    home.packages = [
      # antigravity-cli: google's agentic development platform, in the terminal !!
      inputs.llm-agents.packages.${system}.antigravity-cli

      # claude-code: anthropic's coding agent cli !!
      inputs.llm-agents.packages.${system}.claude-code

      # codex: openai's coding agent cli !!
      inputs.llm-agents.packages.${system}.codex

      # herdr: a terminal workspace manager for ai coding agents !!
      inputs.llm-agents.packages.${system}.herdr

      # coding agents (used within llm-agents package!)

      # coco: snowflake's cortex code cli !!
      # inputs.llm-agents.packages.${system}.coco

      # copilot-cli: github's copilot cli !!
      inputs.llm-agents.packages.${system}.copilot-cli

      # cline: an autonomous coding agent cli !!
      # inputs.llm-agents.packages.${system}.cline

      # crush: charmbracelet's glamourous ai coding agent !!
      # inputs.llm-agents.packages.${system}.crush

      # cursor-agent: cursor/spacexai's coding agent cli !!
      inputs.llm-agents.packages.${system}.cursor-agent

      # grok: spacexai's/xai's coding agent cli !!
      # inputs.llm-agents.packages.${system}.grok

      # junie: jetbrains's ai coding agent cli !!
      # inputs.llm-agents.packages.${system}.junie

      # mistral-vibe: mistral ai's minimal coding agent cli !!
      # inputs.llm-agents.packages.${system}.mistral-vibe

      # pi: a wonderful agent harness !!
      inputs.llm-agents.packages.${system}.pi

      # qwen-code: an agent cli / workflow tool for the family of Qwen3 models !!
      # inputs.llm-agents.packages.${system}.qwen-code

      # ai assistants

      # hermes-agent: nous research's self-improving ai agent !!
      inputs.llm-agents.packages.${system}.hermes-agent
    ];
  };
}

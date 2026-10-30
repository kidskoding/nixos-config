{inputs, ...}: {
  flake.homeModules.agents = {pkgs, ...}: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    my.caches = [
      # llm-agents (numtide) cache
      {
        url = "https://cache.numtide.com";
        key = "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=";
      }
    ];

    home.packages = [
      inputs.antigravity-cli.packages.${system}.default
      inputs.claude-code-cli.packages.${system}.default
      inputs.codex-cli.packages.${system}.default

      # coding agents (used within llm-agents package!)
      # inputs.llm-agents.packages.${system}.coco             # snowflake, cortex code cli!
      inputs.llm-agents.packages.${system}.copilot-cli # github copilot cli
      # inputs.llm-agents.packages.${system}.cline            # autonomous coding agent cli!
      # inputs.llm-agents.packages.${system}.crush            # charmbracelet's glamourous ai coding agent!
      inputs.llm-agents.packages.${system}.cursor-agent # cursor/spacexai's coding agent cli!
      # inputs.llm-agents.packages.${system}.grok             # spacexai's/xai's coding agent cli!
      # inputs.llm-agents.packages.${system}.junie            # jetbrains's ai coding agent cli!
      # inputs.llm-agents.packages.${system}.mistral-vibe     # mistral ai's minimal coding agent cli!
      inputs.llm-agents.packages.${system}.pi # a wonderful agent harness!
      # inputs.llm-agents.packages.${system}.qwen-code          # agent cli / workflow tool for the family of Qwen3 models!

      # ai assistants
      inputs.llm-agents.packages.${system}.hermes-agent # hermes-agent cli!
    ];
  };
}

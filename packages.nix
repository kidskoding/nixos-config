{
  inputs,
  pkgs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
in {
  environment.systemPackages = [
    inputs.aoc-cli.packages.${system}.default

    inputs.antigravity-cli.packages.${system}.default
    inputs.claude-code-cli.packages.${system}.default
    inputs.claude-desktop.packages.${system}.claude-desktop-with-fhs
    inputs.codex-cli.packages.${system}.default

    # coding agents (used within llm-agents package!)
    # inputs.llm-agents.packages.${system}.coco             # snowflake, cortex code cli!
    # inputs.llm-agents.packages.${system}.copilot-cli      # github copilot cli
    # inputs.llm-agents.packages.${system}.cline            # autonomous coding agent cli!
    # inputs.llm-agents.packages.${system}.crush            # charmbracelet's glamourous ai coding agent!
    inputs.llm-agents.packages.${system}.cursor-agent # cursor/spacexai's coding agent cli!
    # inputs.llm-agents.packages.${system}.grok             # spacexai's/xai's coding agent cli!
    # inputs.llm-agents.packages.${system}.junie            # jetbrains's ai coding agent cli!
    # inputs.llm-agents.packages.${system}.mistral-vibe     # mistral ai's minimal coding agent cli!
    inputs.llm-agents.packages.${system}.orca # a wonderful ade for working with many coding agents!
    # inputs.llm-agents.packages.${system}.pi               # a wonderful agent harness!
    # inputs.llm-agents.packages.${system}.qwen-code          # agent cli / workflow tool for the family of Qwen3 models!

    # ai assistants
    inputs.llm-agents.packages.${system}.hermes-agent # hermes-agent cli!
    inputs.llm-agents.packages.${system}.hermes-desktop # hermes-agent desktop!

    # rust stable toolchain
    (inputs.fenix.packages.${system}.stable.withComponents [
      "cargo"
      "clippy"
      "rust-analyzer"
      "rust-src"
      "rustc"
      "rustfmt"
    ])

    inputs.nix-vite-plus.packages.${system}.default

    inputs.matui.packages.${system}.default
    inputs.toofan.packages.${system}.default

    inputs.cromite.packages.${system}.default
    inputs.zen-browser.packages.${system}.default
  ];
}

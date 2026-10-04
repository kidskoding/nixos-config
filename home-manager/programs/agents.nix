{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [inputs.anikonistack.homeManagerModules.default];

  anikonistack = {
    bundles = [
      "custom"
      "mattpocock"
      "obsidian"
      "extras"
      "superpowers"
      "firecrawl"
      "frontend-design"
      "caveman"
      "ponytail"
      "understand-anything"
      "last30days"
      "duet"

      "spartan-core"
      "spartan-database"
      "spartan-shared-backend"
      "spartan-backend-micronaut"
      "spartan-frontend-react"
      "spartan-ux-design"
      "spartan-infrastructure"
      "spartan-product"
      "spartan-ops"
      "spartan-research"
    ];
    skip = ["resolving-merge-conflicts"];

    agents = {
      claude-code = {
        enable = true;
        statusline = true;
      };

      codex.enable = true;
      opencode.enable = true;
      antigravity.enable = true;
      cursor.enable = true;
    };
  };

  programs.mcp = {
    enable = true;

    servers = {
      composio.url = "https://connect.composio.dev/mcp";

      github = {
        url = "https://api.githubcopilot.com/mcp";
        headers.Authorization = "Bearer \${GITHUB_MCP_TOKEN}";
      };

      playwright = {
        command = "npx";
        args = ["@playwright/mcp@latest" "--extension"];
        env.PLAYWRIGHT_MCP_EXTENSION_TOKEN = "\${PLAYWRIGHT_MCP_EXTENSION_TOKEN}";
      };
    };
  };

  home.packages = with pkgs; [gh nodejs starship];

  programs.claude-code = {
    package = null;

    settings = {
      model = "claude-opus-5-5[1m]";
      modelSettings.claude-opus-5-5.effortLevel = "high";
      effortLevel = "xhigh";
      theme = "dark";
      tui = "fullscreen";
      skipWorkflowUsageWarning = true;
      agentPushNotifEnabled = true;
      env.DISABLE_AUTOUPDATER = "1";

      permissions.allow = [
        "Bash(git commit*)"
        "Bash(git push*)"
        "Bash(git add*)"
        "Bash(git status*)"
        "Bash(git diff*)"
        "Bash(git log*)"
      ];
    };

    settings.autoMode.environment = [
      "### Org-wide"
      "**Organization**: None configured"
      "**Cloud provider(s)**: None configured"
      "**Repository visibility**: assume private unless the remote host and repo name indicate otherwise, or a visibility check in the transcript shows public — not queryable for this repo (no remote configured)"
      "**Internal sharing / snippet hosting**: None configured — treat public paste/gist services as outside the trust boundary"
      "**Secrets management**: None configured"
      "**Default / protected branches**: (unknown — origin/HEAD unset, no remotes configured)"
      "**CI/CD deploy targets**: None configured"
      "**Network posture**: None configured"
      "**Host containment**: None configured — assume Claude Code runs on an ordinary developer machine or CI runner with open internet"
      "**Source control**: The trusted repo only (no remotes configured, no additional orgs configured)"
      "**Trusted internal domains**: None configured"
      "**Trusted cloud buckets**: None configured"
      "**Key internal services**: None configured"
      "**Internal package registry**: None configured"
      "**Sensitive data locations & audiences**: any file or store holding personal data, confidential business data, credentials, regulated data, or similarly sensitive material — including .claude/.credentials.json, nixos/secrets/secrets.yaml, and .envrc / credentials.yml.enc files found across ~/'s repos; preserve exact handles when known and share only with audiences cleared at the [named+specifics] bar"
      "**Data retention / declassification**: None configured"
      "**Sensitive remote targets**: any namespace, host, or container whose name carries `prod` or `production` as a whole word or name segment"
      "**Protected deployment namespaces / environments**: None configured — fall back to the Sensitive remote targets heuristic"
      "**Protected IaC scopes**: IAM, RBAC, networking, quota, and node-pool resources; anything whose name or tag carries `prod` or `production` as a whole word or name segment"
      "### User-specific"
      "**Primary use of Claude Code**: software development (personal/hobby projects — dotfiles, AoC, interview prep, small apps)"
      "**Trusted repo**: /home/anirudh — this directory has no tracked files and no git remotes configured; treat as an untracked working directory, not an established repo"
      "**Org-specific CLIs**: None configured — personal toolchain observed (nix, cargo, go, uv, bun, sops, gh) but no org-specific wrapper CLIs found"
      "**Routine under kidskoding/ prefix**: git and gh operations against github.com/kidskoding/* repos (this user's own personal GitHub account, seen across ~15 sibling checkouts) may be treated as routine within those repos' own scope; contributing/* checkouts also have upstream remotes (ratatui/ratatui, EpicGames/lore, scarvalhojr/aoc-cli) which are third-party — pushes there are out-of-place publication, not routine"
    ];
  };

  programs.codex.package = null;

  home.file.".codex/config.toml".enable = false;
  home.activation.codexConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run install -m644 ${config.home.file.".codex/config.toml".source} "$HOME/.codex/config.toml"
  '';

  programs.antigravity-cli = {
    package = null;

    settings.trustedWorkspaces = [
      "/home/anirudh"
      "/home/anirudh/personal-projects"
      "/home/anirudh/nixos"
    ];
  };
}

{
  dependencies.claude-code.enable = false;

  plugins = {
    claudecode.enable = true;

    codecompanion = {
      enable = true;

      settings.interactions = {
        chat.adapter = "claude_code";
        inline.adapter = "claude_code";
      };
    };
  };
}

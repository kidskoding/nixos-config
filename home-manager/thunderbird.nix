{ ... }:

{
  programs.thunderbird = {
    enable = true;
    profiles.default = {
      isDefault = true;
      settings = {
        "extensions.activeThemeID" = "thunderbird-compact-dark@mozilla.org";
        # Force dark regardless of the desktop's color-scheme setting.
        "ui.systemUsesDarkTheme" = 1;
        "browser.theme.toolbar-theme" = 0; # 0 = dark toolbar (old profile had this too)
        # Show List-Unsubscribe in the filter editor's header dropdown.
        "mailnews.customHeaders" = "List-Unsubscribe";
      };
    };
  };

  accounts.email.accounts.gmail = {
    primary = true;
    flavor = "gmail.com";
    address = "anirudhkonidala@gmail.com";
    realName = "Anirudh Konidala";
    imap.authentication = "xoauth2";
    smtp.authentication = "xoauth2";

    thunderbird = {
      enable = true;
      # Account name shown in the folder pane (defaults to the attr key, "gmail").
      settings = id: {
        "mail.server.server_${id}.name" = "anirudhkonidala@gmail.com";
      };

      # Outlook-style Focused/Other: bulk mail carries a List-Unsubscribe
      # header, humans writing to you don't. Move it out of the Inbox.
      messageFilters = [
        {
          name = "Other (bulk mail)";
          type = "17"; # incoming mail, before junk classification
          action = "Move to folder";
          actionValue = "imap://anirudhkonidala%40gmail.com@imap.gmail.com/Other";
          condition = ''OR (\"List-Unsubscribe\",contains,http) OR (\"List-Unsubscribe\",contains,mailto)'';
        }
      ];
    };
  };
}

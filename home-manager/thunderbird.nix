{ ... }:

let
  bulkToOther = folderUri: [
    {
      name = "Other (bulk mail)";
      type = "17";
      action = "Move to folder";
      actionValue = folderUri;
      condition = ''OR (\"List-Unsubscribe\",contains,http) OR (\"List-Unsubscribe\",contains,mailto)'';
    }
  ];
in
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
      settings = id: {
        "mail.server.server_${id}.name" = "anirudhkonidala@gmail.com";
      };
      messageFilters = bulkToOther "imap://anirudhkonidala%40gmail.com@imap.gmail.com/Other";
    };
  };

  # UIUC Microsoft 365 over IMAP + OAuth2. The Exchange/Graph route needs
  # tenant admin consent that UIUC hasn't granted; IMAP is what their own
  # Thunderbird docs describe.
  accounts.email.accounts.uiuc = {
    flavor = "outlook.office365.com";
    address = "ak123@illinois.edu";
    realName = "Anirudh Konidala";
    imap.authentication = "xoauth2";
    smtp.authentication = "xoauth2";

    thunderbird = {
      enable = true;
      settings = id: {
        "mail.server.server_${id}.name" = "ak123@illinois.edu";
        "mail.server.server_${id}.using_subscription" = false;
      };
      messageFilters = bulkToOther "imap://ak123%40illinois.edu@outlook.office365.com/Other";
    };
  };
}

{inputs, ...}: {
  flake.homeModules.desktop = {
    imports = [inputs.zen-browser.homeModules.beta];

    stylix.targets.zen-browser = {
      profileNames = ["default"];
      enableCss = false;
    };

    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      profiles.default = {
        name = "Default Profile";
        path = "cw0i5llc.Default Profile";
        isDefault = true;
        settings."widget.use-xdg-desktop-portal.file-picker" = 1;
        presets.catppuccin = {
          enable = true;
          flavor = "Macchiato";
          accent = "Mauve";
        };

        pinsForce = true;
        pinsForceAction = "demote";

        pins = {
          # space 1 (anirudh) essentials !!
          "nixos packages" = {
            id = "d0185d55-6840-4fed-989a-63b8ed6dea40";
            url = "https://search.nixos.org/packages";
            position = 1000;
            isEssential = true;
          };
          "youtube" = {
            id = "31b01a47-aabf-4c86-a7b7-ff086bc81f4b";
            url = "https://www.youtube.com/";
            position = 2000;
            isEssential = true;
          };
          "reddit" = {
            id = "a1b4c0fa-6357-47bd-927c-4825f20ffd6a";
            url = "https://www.reddit.com/";
            position = 3000;
            isEssential = true;
          };
          "chatgpt" = {
            id = "e4473b65-796d-4a37-951c-733eac01cb69";
            url = "https://chatgpt.com/";
            position = 4000;
            isEssential = true;
          };
          "claude" = {
            id = "dcd69a42-80c8-4e76-a977-b25e5620d123";
            url = "https://claude.ai/new";
            position = 5000;
            isEssential = true;
          };
          "github" = {
            id = "e58557d5-11c3-4e28-81cd-3f2b938d1741";
            url = "https://github.com/kidskoding";
            position = 6000;
            isEssential = true;
          };
          "google calendar" = {
            id = "ce03673b-d3da-425d-ba0c-6639069dce5d";
            url = "https://calendar.google.com/calendar/u/0/r";
            position = 7000;
            isEssential = true;
          };
          "codesession" = {
            id = "52dfe3f7-4ea1-4a46-87a0-876a9361fbe1";
            url = "https://www.codesession.io/";
            position = 8000;
            isEssential = true;
          };
          "linkedin" = {
            id = "26ddc0eb-5ae6-44a7-8046-61cbb563d09c";
            url = "https://www.linkedin.com/in/anirudh-konidala/";
            position = 9000;
            isEssential = true;
          };
          "my site" = {
            id = "965076ca-7546-4993-bd52-0ef530a4a0fd";
            url = "https://anirudh-konidala.vercel.app/";
            position = 10000;
            isEssential = true;
          };
          "databricks" = {
            id = "f793e530-6324-4b8d-928a-03e863dc6697";
            url = "https://login.databricks.com/";
            position = 11000;
            isEssential = true;
          };

          # space 2 (ak123 - anirudh uiuc) essentials !!
          "outlook" = {
            id = "3725d2f8-7fa8-449d-894e-d506935e3f6c";
            url = "https://outlook.cloud.microsoft/mail/";
            container = 2;
            position = 12000;
            isEssential = true;
          };
          "canvas" = {
            id = "86c5e44e-d18e-498b-a90a-d361c64f6576";
            url = "https://canvas.illinois.edu/";
            container = 2;
            position = 13000;
            isEssential = true;
          };
          "uiuc claude" = {
            id = "6205684c-0e51-4200-9565-be9a6ded6d3b";
            url = "https://claude.ai/new";
            container = 2;
            position = 14000;
            isEssential = true;
          };
          "prairielearn" = {
            id = "1b0395b6-83a1-4ae7-ab0a-7b6e6e8a7aac";
            url = "https://us.prairielearn.com/";
            container = 2;
            position = 15000;
            isEssential = true;
          };
          "gradescope" = {
            id = "10eeafa7-8aa0-47f2-957b-c45f6a92a6ff";
            url = "https://www.gradescope.com/";
            container = 2;
            position = 16000;
            isEssential = true;
          };
          "illinois media space" = {
            id = "9728ea3a-64d0-4c8d-8369-99a9b6a04e38";
            url = "https://mediaspace.illinois.edu/";
            container = 2;
            position = 17000;
            isEssential = true;
          };
          "when2meet" = {
            id = "b0a377ca-6e2d-415e-93fa-4259f55e0b46";
            url = "https://www.when2meet.com/";
            container = 2;
            position = 18000;
            isEssential = true;
          };
          "uiuc drive" = {
            id = "c866c8a1-4535-4326-9586-223181d3a011";
            url = "https://drive.google.com/drive/";
            container = 2;
            position = 19000;
            isEssential = true;
          };
          "illinois calendar" = {
            id = "ba27559b-feb0-4da1-a596-9c081d35e07a";
            url = "https://calendar.google.com/calendar/u/0/r";
            container = 2;
            position = 20000;
            isEssential = true;
          };

          # space 3 (agentic ai @ uiuc) essentials !!
          "agentic ai github" = {
            id = "0cbaabce-101f-42c8-a065-f5708499da81";
            url = "https://github.com/Agentic-AI-UIUC/";
            container = 3;
            position = 21000;
            isEssential = true;
          };
          "agentic ai calendar" = {
            id = "6cea8947-a1c2-4014-ac63-9dcd92a6596f";
            url = "https://calendar.google.com/calendar/u/0/r/week";
            container = 3;
            position = 22000;
            isEssential = true;
          };
          "agentic ai gmail" = {
            id = "934b8e0e-b0b0-4489-b723-dee5fc060c59";
            url = "https://mail.google.com/mail/u/0/#inbox";
            container = 3;
            position = 23000;
            isEssential = true;
          };
          "agentic ai drive" = {
            id = "e832d8ff-3ac2-4c6c-8117-d1e1d2d1a35b";
            url = "https://drive.google.com/drive/";
            container = 3;
            position = 24000;
            isEssential = true;
          };
          "luma" = {
            id = "f2e2e40a-71e4-4abe-83ca-db40fafdf131";
            url = "https://luma.com/";
            container = 3;
            position = 25000;
            isEssential = true;
          };
          "agenticaiuiuc.com" = {
            id = "03b6e6a1-0055-4569-80ac-25b8229ded13";
            url = "https://agenticaiuiuc.com/";
            container = 3;
            position = 26000;
            isEssential = true;
          };
        };

        spaces = {
          # first space: catppuccin macchiato overlay1 (grey) !!
          anirudh = {
            id = "9affa4c3-c2f7-4755-b40e-31bc22123308";
            position = 1000;
            icon = "chrome://browser/skin/zen-icons/selectable/lock-closed.svg";
            theme = {
              opacity = 0.5;
              colors = [
                {
                  red = 128;
                  green = 135;
                  blue = 162;
                }
              ];
            };
          };

          # second space: catppuccin macchiato blue !!
          "ak123 - anirudh uiuc" = {
            id = "fd848d8b-4257-4a49-b145-5ccee1e57699";
            container = 2;
            position = 2000;
            icon = "🎒";
            theme = {
              opacity = 0.8;
              colors = [
                {
                  red = 138;
                  green = 173;
                  blue = 244;
                }
              ];
            };
          };

          # third space: catppuccin macchiato yellow !!
          "agentic ai @ uiuc" = {
            id = "9a0ab72e-2f04-4180-bd0e-673dd32c1714";
            container = 3;
            position = 3000;
            icon = "👨‍💻";
            theme = {
              opacity = 0.8;
              colors = [
                {
                  red = 238;
                  green = 212;
                  blue = 159;
                }
              ];
            };
          };
        };
      };

      policies.ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };

        "@react-devtools" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/react-devtools/latest.xpi";
          installation_mode = "force_installed";
        };

        "chrome2fox@neguiolidas.github.io" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/chrome2fox/latest.xpi";
          installation_mode = "force_installed";
        };

        "{203625b5-20fd-4b20-8bb5-76f07455d18b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/add-ons_google_chrome/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
}

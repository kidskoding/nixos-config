{config, ...}: {
  sops = {
    secrets = {
      "wifi/home" = {};
      "wifi/uiuc" = {};
      "wifi/brunswick" = {};
      "wifi/hotspot" = {};
    };

    templates = {
      "wifi.env" = {
        content = ''
          RUDY2015_PSK="${config.sops.placeholder."wifi/home"}"
          ILLINOISNET_PSK="${config.sops.placeholder."wifi/uiuc"}"
          BRNIJET_PSK="${config.sops.placeholder."wifi/brunswick"}"
          ANIRUDHIPHONE17_PSK="${config.sops.placeholder."wifi/hotspot"}"
        '';
      };
    };
  };

  networking.hostName = "nixos";
  networking.networkmanager = {
    enable = true;

    ensureProfiles = {
      environmentFiles = [config.sops.templates."wifi.env".path];

      profiles = {
        home = {
          connection = {
            id = "Rudy2015";
            type = "wifi";
          };

          wifi.ssid = "Rudy2015";

          wifi-security = {
            key-mgmt = "wpa-psk";
            psk = "$RUDY2015_PSK";
          };
        };

        octave = {
          connection = {
            id = "5G Octave";
            type = "wifi";
          };

          wifi.ssid = "5G Octave";
        };

        uiuc = {
          connection = {
            id = "IllinoisNet";
            type = "wifi";
          };

          wifi.ssid = "IllinoisNet";
          wifi-security.key-mgmt = "wpa-eap";

          "802-1x" = {
            eap = "peap;";
            identity = "ak123";
            phase2-auth = "mschapv2";
            password = "$ILLINOISNET_PSK";
          };
        };

        brunswick = {
          connection = {
            id = "BRN-iJet";
            type = "wifi";
          };

          wifi.ssid = "BRN-iJet";

          wifi-security = {
            key-mgmt = "wpa-psk";
            psk = "$BRNIJET_PSK";
          };
        };

        hotspot = {
          connection = {
            id = "Anirudh's iPhone 17";
            type = "wifi";
          };

          wifi.ssid = "Anirudh's iPhone 17";

          wifi-security = {
            key-mgmt = "wpa-psk";
            psk = "$ANIRUDHIPHONE17_PSK";
          };
        };
      };
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };
}

{ config, inputs, ... }:

{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/anirudh/.config/sops/age/keys.txt";

    secrets = {
      "wifi/home" = {};
      "wifi/home2" = {};
      "wifi/uiuc" = {};
    };

    templates = {
      "wifi.env" = {
        content = ''
          RUDY2015_PSK="${config.sops.placeholder."wifi/home"}"
          BECKYBEND_PSK="${config.sops.placeholder."wifi/home2"}"
          ILLINOISNET_PSK="${config.sops.placeholder."wifi/uiuc"}"
        '';
      };
    };
  };

  networking.hostName = "nixos";
  networking.networkmanager = {
    enable = true;

    ensureProfiles = {
      environmentFiles = [ config.sops.templates."wifi.env".path ];

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

        home2 = {
          connection = {
            id = "BeckyBend";
            type = "wifi";
          };

          wifi.ssid = "BeckyBend";

          wifi-security = {
            key-mgmt = "wpa-psk";
            psk = "$BECKYBEND_PSK";
          };
        };

        octave = {
          connection = {
            id = "Octave 5G";
            type = "wifi";
          };

          wifi.ssid = "Octave 5G";
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
      };
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };
}

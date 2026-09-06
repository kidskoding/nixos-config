{ inputs, pkgs, ... }:

{
  programs.noctalia-shell.package =
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
      postPatch = (old.postPatch or "") + ''
        substituteInPlace Modules/LockScreen/LockScreenPanel.qml \
          --replace-fail $'backgroundColor: Color.mError' $'backgroundColor: Color.mError\n            hoverColor: Color.mError\n            textHoverColor: Color.mOnError' \
          --replace-fail $'Layout.fillWidth: batteryIndicator.isReady' $'Layout.fillWidth: true' \
          --replace-fail $'Layout.alignment: (batteryIndicator.isReady) ? (Qt.AlignRight | Qt.AlignVCenter) : Qt.AlignVCenter' $'Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter' \
          --replace-fail $'        Item {\n          Layout.preferredWidth: Style.marginM\n        }\n      }\n\n      // Password input' $'        Item {\n          Layout.fillWidth: true\n        }\n      }\n\n      // Password input'
      '';
    });

  programs.noctalia-shell.settings.idle = {
    enabled = true;
    lockTimeout = 300;
    screenOffTimeout = 330;
    suspendTimeout = 900;
  };

  programs.niri.settings.binds."Mod+Ctrl+L".action.spawn =
    [ "noctalia-shell" "ipc" "call" "sessionMenu" "lock" ];
}

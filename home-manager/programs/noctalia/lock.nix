{ inputs, pkgs, ... }:

{
  programs.noctalia-shell.package =
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
      postPatch = (old.postPatch or "") + ''
        substituteInPlace Modules/Panels/Media/MediaPlayerPanel.qml \
          --replace-fail $'        Layout.preferredHeight: headerRow.implicitHeight + Style.margin2M' $'        visible: false' \
          --replace-fail $'        Layout.preferredHeight: mediaContentGrid.implicitHeight + Style.margin2M\n' $'        Layout.preferredHeight: mediaContentGrid.implicitHeight + Style.margin2M\n\n        NIconButton {\n          anchors.top: parent.top\n          anchors.right: parent.right\n          anchors.margins: Style.marginS\n          z: 2\n          icon: "close"\n          baseSize: Style.baseWidgetSize * 0.6\n          onClicked: root.close()\n        }\n'
        substituteInPlace Modules/Panels/Battery/BatteryPanel.qml \
          --replace-fail $'        implicitHeight: headerRow.implicitHeight + Style.margin2M' $'        visible: false' \
          --replace-fail $'        implicitHeight: chargeLayout.implicitHeight + Style.margin2L\n' $'        implicitHeight: chargeLayout.implicitHeight + Style.margin2L\n\n        NIconButton {\n          anchors.top: parent.top\n          anchors.right: parent.right\n          anchors.margins: Style.marginS\n          z: 2\n          icon: "close"\n          baseSize: Style.baseWidgetSize * 0.6\n          onClicked: root.close()\n        }\n'
        substituteInPlace Modules/Panels/Brightness/BrightnessPanel.qml \
          --replace-fail $'        implicitHeight: headerRow.implicitHeight + Style.margin2M' $'        visible: false' \
          --replace-fail $'              Layout.preferredHeight: outputColumn.implicitHeight + Style.margin2M\n' $'              Layout.preferredHeight: outputColumn.implicitHeight + Style.margin2M\n\n              NIconButton {\n                visible: index === 0\n                anchors.top: parent.top\n                anchors.right: parent.right\n                anchors.margins: Style.marginS\n                z: 2\n                icon: "close"\n                baseSize: Style.baseWidgetSize * 0.6\n                onClicked: root.close()\n              }\n'
        substituteInPlace Modules/LockScreen/LockScreenPanel.qml \
          --replace-fail $'backgroundColor: Color.mError' $'backgroundColor: Color.mError\n            hoverColor: Color.mError\n            textHoverColor: Color.mOnError' \
          --replace-fail $'Layout.fillWidth: batteryIndicator.isReady' $'Layout.preferredWidth: Style.marginM' \
          --replace-fail $'Layout.fillWidth: !(Settings.data.location.weatherEnabled && LocationService.data.weather !== null)' $'Layout.fillWidth: false' \
          --replace-fail $'          Layout.preferredWidth: Style.marginM\n          visible: MediaService.currentPlayer && MediaService.canPlay\n' $'          Layout.fillWidth: true\n' \
          --replace-fail $'        ColumnLayout {\n          Layout.alignment: (batteryIndicator.isReady) ? (Qt.AlignRight | Qt.AlignVCenter) : Qt.AlignVCenter\n          spacing: Style.marginM' $'        RowLayout {\n          Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter\n          spacing: Style.marginXL' \
          --replace-fail $'        Item {\n          Layout.preferredWidth: Style.marginM\n        }\n      }\n\n      // Password input' $'        Item {\n          Layout.fillWidth: true\n        }\n      }\n\n      // Password input' \
          --replace-fail $'visible: MediaService.currentPlayer && MediaService.canPlay' $'visible: true' \
          --replace-fail $'visible: !(MediaService.currentPlayer && MediaService.canPlay)' $'visible: false' \
          --replace-fail $'Layout.preferredWidth: 220' $'Layout.preferredWidth: 360' \
          --replace-fail $'visible: keyboardLayout.currentLayout !== "Unknown"' $'visible: false' \
          --replace-fail $'              NText {\n                text: MediaService.trackTitle || "No media"\n                pointSize: Style.fontSizeM\n                color: Color.mOnSurface\n                Layout.fillWidth: true\n                elide: Text.ElideRight\n              }' $'              NScrollText {\n                text: MediaService.trackTitle || "No media"\n                Layout.fillWidth: true\n                maxWidth: parent.width\n                scrollMode: NScrollText.ScrollMode.Always\n                delegate: NText {\n                  pointSize: Style.fontSizeM\n                  color: Color.mOnSurface\n                }\n              }' \
          --replace-fail $'              NText {\n                text: MediaService.trackArtist || ""\n                pointSize: Style.fontSizeM\n                color: Color.mOnSurfaceVariant\n                Layout.fillWidth: true\n                elide: Text.ElideRight\n              }' $'              NScrollText {\n                text: MediaService.trackArtist || ""\n                Layout.fillWidth: true\n                maxWidth: parent.width\n                scrollMode: NScrollText.ScrollMode.Always\n                delegate: NText {\n                  pointSize: Style.fontSizeM\n                  color: Color.mOnSurfaceVariant\n                }\n              }'
      '';
    });

  services.hypridle = {
    enable = true;
    settings.general = {
      lock_cmd = "noctalia-shell ipc call lockScreen lock";
      before_sleep_cmd = "noctalia-shell ipc call lockScreen lock";
    };
  };

  programs.noctalia-shell.settings.general = {
    clockFormat = "hh\\nmm\\nAP";
    enableLockScreenMediaControls = true;
  };

  programs.noctalia-shell.settings.idle = {
    enabled = true;
    lockTimeout = 300;
    screenOffTimeout = 330;
    suspendTimeout = 900;
  };

  programs.niri.settings.binds."Mod+Ctrl+L".action.spawn =
    [ "noctalia-shell" "ipc" "call" "sessionMenu" "lock" ];
}

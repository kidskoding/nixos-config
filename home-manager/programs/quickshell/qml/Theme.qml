pragma Singleton
import QtQuick

QtObject {
  readonly property color aqua: "#689d6a"
  readonly property color aquaBright: "#8ec07c"
  readonly property color bg: "#282828"
  readonly property color bgAlt: "#3c3836"
  readonly property color black: "#282828"
  readonly property color blue: "#458588"
  readonly property color blueBright: "#83a598"
  readonly property color fg: "#ebdbb2"
  readonly property color fgBright: "#ebdbb2"
  readonly property color gray: "#a89984"
  readonly property color grayBright: "#928374"
  readonly property color green: "#98971a"
  readonly property color greenBright: "#b8bb26"
  readonly property color purple: "#b16286"
  readonly property color purpleBright: "#d3869b"
  readonly property color red: "#cc241d"
  readonly property color redBright: "#fb4934"
  readonly property color yellow: "#d79921"
  readonly property color yellowBright: "#fabd2f"

  readonly property string font: "Terminess Nerd Font Mono"
  readonly property string iconFont: "Symbols Nerd Font"
  readonly property bool dark: true
  readonly property int radius: 12
  readonly property int panelRadius: 16
  readonly property int panelPadding: 18
  readonly property int headingSize: 20
  readonly property real opacity: 0.85
  readonly property int fontSize: 14
}

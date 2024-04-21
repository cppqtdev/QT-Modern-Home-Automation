pragma Singleton
import QtQuick 2.15

QtObject {
    readonly property color background: "#e2e2e2"

    readonly property color white: "#fafafa"
    readonly property color black: "#050506"
    readonly property color red: "#e25141"
    readonly property color blue: "#405ff5"
    readonly property color blueGreen: "#5b32f5"
    readonly property color green: "#5ac461"
    readonly property color yello: "#f19537"
    readonly property color yellowLight: "#e29155"
    readonly property color iconColor: "#4a4a4a"


    property color textColor: "#FFFFFF"
    property color charcoalGrey: "#404040"
    property color granite: "#808080"
    property color paleSlate: "#BFBFBF"
    property color lightColor4: "#000000"

    property color lightLime: "#A5FF5D"
    property color pastelBlue: "#96C6FF"
    property color cinder: "#151515"
    property color seashell: "#F1F1F1"

    property var fontawesomefont: fontawesome.name
    property FontLoader fontawesome: FontLoader{
        source: "qrc:/fonts/fontawesome.otf"
    }

    function alphaColor(color, alpha) {
        let actualColor = Qt.darker(color, 1)
        actualColor.a = alpha
        return actualColor
    }
}

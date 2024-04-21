import QtQuick 2.15
import QtQuick.Controls
import Style 1.0

Label {
    property real size: 24
    property string icon
    property bool appicon: true

    text: icon
    font.pixelSize: size
    font.family: appicon ? Style.fontawesomefont : "Lato"
}

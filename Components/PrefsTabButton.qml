import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Style 1.0
import ".."
TabButton {
    id: root

    property string title: ""
    property string textIcon: ""
    property color iconColor: Style.blue

    implicitWidth: 65
    implicitHeight: 110

    background: ShadowRectangle {
        anchors.fill: parent
        radius: parent.height /2
        visible: root.checked
    }

    contentItem: Item {
        width: parent.width
        height: layout.implicitHeight
        ColumnLayout {
            id: layout
            anchors.centerIn: parent
            spacing: 10
            ShadowRectangle {
                Layout.alignment: Qt.AlignHCenter
                implicitHeight: 60
                implicitWidth: 60
                radius: parent.height /2
                color: !root.checked ? Style.white : "#00000000"

                OutlinedLabel {
                    anchors.centerIn: parent
                    textIcon: root.textIcon
                    iconSize: 18
                    radius: implicitHeight /2
                    borderColor: backgroundColor
                    color: root.iconColor
                    backgroundColor: Style.alphaColor(root.iconColor,0.2)
                    implicitHeight: root.checked ? 55 : 45
                    implicitWidth: root.checked ? 55 : 45
                }
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                Layout.bottomMargin: 10
                font.pixelSize: 14
                font.bold: Font.Bold
                font.weight: Font.Medium
                text: root.title
            }
        }
    }
}

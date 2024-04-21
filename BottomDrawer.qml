import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.impl
import QtQuick.Templates as T
import "Components"
Drawer {
    edge: Qt.BottomEdge
    width: parent.width * 0.3
    height: 80
    background: RoundRectangle {
        width: parent.width; height: parent.height
        color: Style.white
        radius: 30
        corners: Qt.AlignRight | Qt.AlignTop
    }

    T.Overlay.modal: Rectangle {
        color: "#00000000"
    }

    T.Overlay.modeless: Rectangle {
        color: "#00000000"
    }

    contentItem: Item {
        anchors.fill: parent
        RowLayout {
            anchors.centerIn: parent
            width: parent.width
            OutlinedButtonWithicon {
                Layout.alignment: Qt.AlignHCenter
                textIcon: "\uf015"
                text: qsTr("Room")
                backgroundColor: Style.black
            }

            OutlinedLabel {
                Layout.alignment: Qt.AlignHCenter
                textIcon: "\uf03d"
                iconSize: 18
                radius: 24
                color: Style.iconColor
                backgroundColor: Style.alphaColor("#000000",0.2)
                borderColor: backgroundColor
                implicitHeight: 48
                implicitWidth: 48
            }

            OutlinedButtonWithicon {
                iconSize: 16
                Layout.alignment: Qt.AlignHCenter
                textIcon: "\uf6ff"
                text: qsTr("Device")
                backgroundColor: Style.black
            }

            OutlinedLabel {
                Layout.alignment: Qt.AlignHCenter
                textIcon: "\uf130"
                color: Style.iconColor
                iconSize: 18
                radius: 24
                backgroundColor: "#00000000"
                borderColor: Style.iconColor
                implicitHeight: 48
                implicitWidth: 48
            }
        }
    }
}

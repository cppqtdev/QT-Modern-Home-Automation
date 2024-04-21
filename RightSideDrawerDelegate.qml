import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import "Components"

ItemDelegate {
    width: 160
    height: 160
    background: Rectangle {
        id: backgroundID
        anchors.fill: parent
        color: Style.white
        radius: 16
    }

    DropShadow {
        anchors.fill: backgroundID
        horizontalOffset: 2
        verticalOffset: 2
        radius: 8.0
        samples: 18
        color: Style.alphaColor("#80000000",0.3)
        source: backgroundID
    }

    DropShadow {
        anchors.fill: backgroundID
        horizontalOffset: -1
        verticalOffset: -1
        radius: 8.0
        samples: 18
        color: Style.alphaColor("#80000000",0.2)
        source: backgroundID
    }

    contentItem: Item{
        anchors.fill: parent
        ColumnLayout {
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.top: parent.top
            anchors.topMargin: 8
            spacing: 5

            OutlinedLabel {
                Layout.alignment: Qt.AlignHCenter
                textIcon: "\uf1e6"
                iconSize: 14
                implicitHeight: 28
                implicitWidth: 28
                radius: 18
                color: Style.green
                backgroundColor: Style.alphaColor(Style.green,0.2)
            }
            OutlinedLabel {
                Layout.alignment: Qt.AlignHCenter
                textIcon: "\uf1eb"
                iconSize: 12
                implicitHeight: 28
                implicitWidth: 28
                radius: 18
                color: Style.blue
                backgroundColor: Style.alphaColor(Style.blue,0.2)
            }
        }

        ColumnLayout {
            width: parent.width * 0.7
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.top: parent.top
            anchors.topMargin: 8

            Text {
                Layout.preferredWidth: parent.width
                Layout.alignment: Qt.AlignHCenter | Qt.AlignLeft
                text: qsTr("Google Home Max Charcol")
                font.pixelSize: 14
                font.bold: Font.Bold
                font.weight: Font.ExtraBold
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }

            Text {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignLeft
                text: qsTr("Opening")
                font.pixelSize: 14
            }
        }

        Image{
            source: "qrc:/assets/icons/1.png"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            sourceSize: Qt.size(160,160)
        }

        OutlinedLabel {
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8

            textIcon: "\uf06a"
            iconSize: 14
            implicitHeight: 28
            implicitWidth: 28
            radius: 18
            color: Style.red
            backgroundColor: Style.alphaColor(Style.red,0.2)
        }
    }
}

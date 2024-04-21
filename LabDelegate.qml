import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import Style

import "Components"

ShadowRectangle {

    property bool showInfo: false
    property string icon: "\uf03d"
    property string title: "Study Lanp"
    property bool isAvaible: false
    property bool isOpen: false

    id: control
    Layout.fillWidth: true
    Layout.preferredHeight: 60

    IconLabel {
        visible: showInfo && !isAvaible
        icon:  "\uf06a"
        size: 18
        color: Style.alphaColor(Style.red,0.6)
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.top: parent.top
        anchors.topMargin: 8
    }

    RowLayout {
        anchors.centerIn: parent
        width: parent.width
        spacing: 10

        ShadowRectangle {
            Layout.leftMargin: 5
            Layout.alignment: Qt.AlignVCenter
            implicitHeight: 52
            implicitWidth: 52
            radius: implicitHeight / 2
            OutlinedLabel {
                anchors.centerIn: parent
                textIcon: control.icon
                iconSize: 18
                radius: 24
                color: isAvaible && isOpen ? Style.green : Style.iconColor
                backgroundColor: Style.alphaColor(color,0.2)
                borderColor: backgroundColor
                implicitHeight: 42
                implicitWidth: 42
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            Text {
                font.pixelSize: 16
                font.bold: Font.Bold
                font.weight: Font.Medium
                text: title
            }
            Text {
                font.pixelSize: 12
                text: isAvaible ? isOpen ? qsTr("Opened") : qsTr("Closed") : qsTr("Unavaible")
                color: Style.alphaColor("#000000",0.2)
            }
        }

        Item { Layout.fillWidth: true }
    }
}


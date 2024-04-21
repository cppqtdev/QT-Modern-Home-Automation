import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import Style 1.0
import "."
import ".."
ShadowRectangle {
    id: control

    property bool on: false
    property string icon: '\uf1eb'
    property color iconColor: "#e7e7e9"
    property string title: qsTr("Smart Lamp")
    property string subTitle: qsTr("Living Room")
    property string tag: qsTr("Wi-Fi")
    property string iconImage: "qrc:/assets/icons/sun.svg"

    property bool inActive: false

    width: 160
    height: 160
    radius: 16

    PrefsSwitch {
        id: switchOn
        checked: control.on
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        onToggled: {
            if(!inActive){
                control.on = !control.on
            }
        }
    }

    ShadowRectangle {
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        implicitHeight: 52
        implicitWidth: 52
        radius: implicitHeight / 2
        ImageButton {
            anchors.centerIn: parent
            iconImage: control.iconImage
            iconWidth: 24
            iconHeight: 24
            color: inActive ? Style.red : control.on ? Style.green : Style.blue
            backgroundColor: Style.alphaColor(color,0.1)
        }
    }

    ColumnLayout {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        spacing: 5

        OutlinedLabel {
            visible: inActive
            Layout.alignment: Qt.AlignHCenter
            textIcon: "\uf06a"
            iconSize: 14
            implicitHeight: 28
            implicitWidth: 28
            radius: 18
            color: Style.red
            backgroundColor: Style.alphaColor(Style.red,0.2)
        }

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
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10

        Text {
            text: control.title
            font.pixelSize: 16
            font.bold: Font.DemiBold
            color: "#505050"
        }

        Text {
            text: control.subTitle
            font.pixelSize: 12
            color: "#505050"
        }        
    }
}


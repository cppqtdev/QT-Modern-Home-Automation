import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.impl 2.12 as Impl
import QtQuick.Layouts

import Style 1.0

import "."
Button {
    id: control

    property color color: Style.textColor
    property color backgroundColor: Style.granite
    property color borderColor: backgroundColor
    property real radius: implicitHeight /2
    property string textIcon
    property int iconSize: 18
    property bool appicon: true

    font.pixelSize: 20
    implicitHeight: 42
    implicitWidth: 42
    background: Rectangle{
        implicitHeight: control.implicitHeight
        implicitWidth: control.implicitWidth
        radius: control.radius
        color: control.backgroundColor
        border.color: control.borderColor

        Rectangle {
            id: indicator
            property int mx
            property int my
            x: mx - width / 2
            y: my - height / 2
            height: width
            radius: width / 2
            color: Qt.lighter("#B8FF01")
        }
    }

    contentItem: IconLabel {
        icon: control.textIcon
        size: control.iconSize
        color: control.color
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        appicon: control.appicon
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
    }

    ParallelAnimation {
        id: anim
        NumberAnimation {
            target: indicator
            property: 'width'
            from: 0
            to: control.width * 1.5
            duration: 200
        }
        NumberAnimation {
            target: indicator;
            property: 'opacity'
            from: 0.9
            to: 0
            duration: 200
        }
    }

    onPressed: {
        indicator.mx = mouseArea.mouseX
        indicator.my = mouseArea.mouseY
        anim.restart();
    }
}

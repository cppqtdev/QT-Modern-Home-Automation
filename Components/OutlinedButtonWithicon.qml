import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts
import QtQuick.Controls.impl 2.12 as Impl
import Style 1.0

import "."

Button {
    id: control

    property color color: Style.textColor
    property color backgroundColor: Style.granite
    property color borderColor: backgroundColor
    property real radius: 24
    property string textIcon
    property int iconSize: 18

    implicitHeight: 48

    font.pixelSize: 18
    font.bold: Font.Bold
    font.weight: Font.Medium

    horizontalPadding: padding + 12
    spacing: 6

    background: Rectangle{
        implicitHeight: control.implicitHeight
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

    contentItem: RowLayout {
        spacing: control.spacing
        IconLabel {
            icon: control.textIcon
            size: control.iconSize
            color: control.color
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
        }

        Impl.IconLabel {
            text: control.text
            font: control.font
            color: control.color
            display: AbstractButton.TextOnly
            spacing: control.spacing
            mirrored: control.mirrored
        }
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

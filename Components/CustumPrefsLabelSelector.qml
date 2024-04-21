import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.impl
import Qt5Compat.GraphicalEffects
import Style 1.0
import "."
import ".."

Pane{
    id:control
    property real radius: 4
    property int allowMaxTags: 5
    property var lableList: ["ON","OFF"]
    property var lableListColors: [Style.blue,Style.red,Style.blueGreen,Style.green,Style.yellowLight]
    property bool appicon: true

    property int iconWidth :24
    property int iconHeight :24

    implicitWidth: layout.implicitWidth
    implicitHeight: 55
    padding: 8
    horizontalPadding: padding
    spacing: 0

    background: ShadowRectangle {
        color: "#e4e4e4d9"
        radius: control.implicitHeight/2
    }

    contentItem: Item{
        anchors.fill: parent
        RowLayout{
            id:layout
            anchors.centerIn: parent
            spacing: 10
            Repeater {
                id:rep
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                width: parent.width
                model: lableList
                delegate: RadioButton {
                    id: labelIndicator
                    Layout.alignment: Qt.AlignVCenter
                    checked: index === 0
                    indicator: null
                    text: modelData

                    background: ShadowRectangle {
                        color: checked ? "#FFFFFF" : "#00000000"
                        radius: control.implicitHeight/2
                        Rectangle {
                            anchors.centerIn: parent
                            width: parent.width - 10
                            height: parent.height - 10
                            radius: height / 2
                            color: checked ? Style.alphaColor(lableListColors[index],0.1) : "#00000000"
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
                    }

                    ParallelAnimation {
                        id: anim
                        NumberAnimation {
                            target: indicator
                            property: 'width'
                            from: 0
                            to: labelIndicator.width * 1.5
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

                    MouseArea {
                        id: mouseArea
                        hoverEnabled: true
                        acceptedButtons: Qt.NoButton
                        cursorShape: Qt.PointingHandCursor
                        anchors.fill: parent
                    }

                    onPressed: {
                        indicator.mx = mouseArea.mouseX
                        indicator.my = mouseArea.mouseY
                        anim.restart();
                    }

                    implicitWidth: 55
                    implicitHeight: 55
                    padding: 0
                    spacing: 0
                    font.family: "Arial"
                    font.pixelSize: 15
                    font.bold: Font.DemiBold

                    contentItem: Item {
                        anchors.fill: parent
                        Image {
                            id: bug
                            anchors.centerIn: parent
                            horizontalAlignment: Qt.AlignHCenter
                            verticalAlignment: Qt.AlignVCenter
                            source: modelData
                            sourceSize: Qt.size(iconWidth,iconHeight)
                            smooth: true
                            visible: false
                        }

                        ColorOverlay {
                            anchors.fill: bug
                            source: bug
                            color: lableListColors[index]
                        }
                    }
                }
            }
        }
    }
}

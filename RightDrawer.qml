import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.impl
import QtQuick.Templates as T

Drawer {
    id: root
    height: parent.height
    width: 200
    edge: Qt.RightEdge

    padding: 0
    background: Rectangle {
        anchors.fill: parent
        color: Style.white
    }

    T.Overlay.modal: Rectangle {
        color: "#00000000"
    }

    T.Overlay.modeless: Rectangle {
        color: "#00000000"
    }

    contentItem: Item {
        anchors.fill: parent

        Rectangle {
           height: 40
           width: 4
           radius: 2
           color: "#bfbfbfd9"
           anchors.verticalCenter: parent.verticalCenter
           anchors.left: parent.left
           anchors.leftMargin: 5
        }

        ListView {
            id: applianceView
            clip: true
            anchors.topMargin: 25
            anchors.bottomMargin: 20
            anchors.fill: parent
            model: 10//gAppliancesModel
            spacing: 20
            delegate: RightSideDrawerDelegate {
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}

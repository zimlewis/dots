import QtQuick
import QtQuick.Templates
import qs.services as Services
import qs.configs as Configs

Slider {
    id: root

	property bool showValue: true

    onMoved: {
        handler.isHovering = true
    }

    HoverHandler {
        id: hoverHandler
        onHoveredChanged: {
            handler.isHovering = hoverHandler.hovered
        }

        cursorShape: Qt.PointingHandCursor
    }
    background: Item {
        Rectangle {
            id: fg
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.topMargin: root.implicitHeight / 2.5
            anchors.bottomMargin: root.implicitHeight / 2.5

            implicitWidth: root.handle.x - root.implicitHeight / 6

            color: Configs.Colors.primary
            radius: Services.Configuration.configs.borderRadius
            topRightRadius: root.implicitHeight / 15
            bottomRightRadius: root.implicitHeight / 15
        }

        Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.topMargin: root.implicitHeight / 2.5
            anchors.bottomMargin: root.implicitHeight / 2.5

            implicitWidth: parent.width - root.handle.x - root.handle.implicitWidth - root.implicitHeight / 6

            color: Configs.Colors.surfaceMuted
            radius: Services.Configuration.configs.borderRadius
            topLeftRadius: root.implicitHeight / 15
            bottomLeftRadius: root.implicitHeight / 15
        }
    }

    handle: Rectangle {
        property bool isHovering: false
        id: handler

        x: root.visualPosition * root.availableWidth - implicitWidth / 2
        anchors.verticalCenter: root.verticalCenter

        implicitWidth: isHovering ? root.implicitHeight : root.implicitHeight / 4.5
        implicitHeight: isHovering ? root.implicitHeight : root.implicitHeight / 2


        color: Configs.Colors.primary
        radius: width * 0.5

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.NoButton
            cursorShape: Qt.PointingHandCursor
        }

        
        Behavior on implicitHeight {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }

        Behavior on implicitWidth {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }

        Text {
            anchors.fill: parent
			visible: root.showValue
            text: Math.round(root.value * 100)
            font.pointSize: root.implicitHeight * 0.35
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: Configs.Fonts.fontFamily
            opacity: handler.isHovering ? 1 : 0
            color: Configs.Colors.primaryFg
            Behavior on opacity {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }
        }
    }
}

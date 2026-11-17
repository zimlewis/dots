import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services as Services

Item {
    id: root
    width: parent.width
    implicitHeight: headerLoader.height + (expanded ? contentLoader.implicitHeight : 0)

    property bool expanded: false
    property Component title
    property Component content
    property color bgColor: "transparent"
    property real radius: Services.Configuration.configs.borderRadius
	property color borderColor: "transparent"
	property int borderWidth: 0
	property bool borderPixelAligned: false

    clip: true


    Behavior on implicitHeight {
        NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
    }

    Rectangle {
        anchors.fill: parent
        color: root.bgColor
        radius: root.radius

		border {
			color: root.borderColor
			width: root.borderWidth
			pixelAligned: root.borderPixelAligned
		}
    }


    Button {
        id: headerWraper
        implicitHeight: headerLoader.height
        width: parent.width
        RowLayout {
            width: parent.width
            implicitHeight: headerLoader.height
            Item {
                width: 10
            }

            Loader {
                id: headerLoader
                Layout.fillWidth: true
                sourceComponent: root.title
                clip: true
            }

            Item {
                width: 10
            }

        }
        variant: Button.ButtonVariant.Ghost
        onClicked: {
            root.expanded = !root.expanded
        }
    }


    Loader {
        id: contentLoader
        width: parent.width
        anchors.top: headerWraper.bottom
        sourceComponent: root.content
    }
}

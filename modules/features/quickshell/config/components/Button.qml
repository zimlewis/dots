import QtQuick
import QtQuick.Layouts
import qs.services
import qs.configs as Configs

Item {
    enum ButtonVariant {
        Default = 0,
        Outline = 1,
        Ghost = 2,
        Destructive = 3,
        Secondary = 4,
        Link = 5
    }

	property bool togglable: false
	property bool activated: false
	property bool disabled: false

	property real disabledOpacity: 0.7
	property int disabledCursor: Qt.ForbiddenCursor

	property int iconSize: 11
	property int textSize: 10

    property color baseBg: activated ? Configs.Colors.surfaceFg : Configs.Colors.surface
    property color primaryBg: activated ? Configs.Colors.primaryFg : Configs.Colors.primary
    property color secondaryBg: activated ? Configs.Colors.secondaryContainerFg : Configs.Colors.secondaryContainer
	property color destructive: activated ? Configs.Colors.errorContainerFg : Configs.Colors.errorContainer

    property color baseFg: activated ? Configs.Colors.surface : Configs.Colors.surfaceFg
    property color primaryFg: activated ? Configs.Colors.primary : Configs.Colors.primaryFg
    property color secondaryFg: activated ? Configs.Colors.secondaryContainer : Configs.Colors.secondaryContainerFg
	property color destructiveFg: activated ? Configs.Colors.errorContainer : Configs.Colors.errorContainerFg

    property color border: Configs.Colors.outline

    property string text: ""
	property string icon: ""

    property int variant: Button.ButtonVariant.Default
    property bool isHovering: hoverHandler.hovered

	property int acceptedButtons: Qt.LeftButton

    property var textColor: {
		let colorToUse = "white"
		switch (root.variant) {
			case 0:
				colorToUse = root.primaryFg;
				break;
			case 1:
				colorToUse = root.baseFg;
				break;
			case 2:
				colorToUse = root.baseFg; 
				break;
			case 3:
				colorToUse = root.destructiveFg;
				break;
			case 4:
				colorToUse = root.secondaryFg;
				break;
			case 5:
				colorToUse = root.baseFg;
				break;

		}

		return colorToUse
	}
    property var bgColor: {
		let colorToUse = "white"
		switch (root.variant) {
			case 0:
				colorToUse = root.primaryBg;
				break;
			case 1:
				colorToUse = root.baseBg;
				break;
			case 2:
				colorToUse = activated ? root.baseBg : "transparent"
				break;
			case 3:
				colorToUse = root.destructive;
				break;
			case 4:
				colorToUse = root.secondaryBg;
				break;
			case 5:
				colorToUse = "transparent";
				break;

		}

		return colorToUse
	}
    property var borderColor: {
		let colorToUse = "transparent"
		if (root.variant == 1) {
			colorToUse = root.border
		}

		return colorToUse
	}

	property var buttonRadius: Configuration.configs.borderRadius

    signal clicked(MouseEvent mouse)

	onClicked: {
		if (root.togglable) {
			root.activated = !root.activated
		}
	}


    id: root
    opacity: {
		if (disabled) {
			return disabledOpacity
		}
        if (isHovering) {
            return 0.7
        }
        else {
            return 1
        }
    }

    
    Behavior on opacity {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    Behavior on scale {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    




    Rectangle {
        anchors.fill: parent
        color: root.bgColor
        border.width: 1
        border.color: root.borderColor
        radius: root.buttonRadius
    }

	RowLayout {
		anchors.fill: parent
		Item {
			Layout.fillWidth: true
		}
		Text {
			id: icon
			Layout.fillHeight: true
			Layout.fillWidth: root.text === ""
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
			font.family: Configs.Fonts.iconFamily
			text: root.icon
			color: root.textColor
			visible: root.icon !== ""
			font.pointSize: root.iconSize
		}

		Item {
			Layout.preferredWidth: 1
			visible: root.icon !== "" && root.text !== ""
		}

		Text {
			id: text
			horizontalAlignment: root.icon === "" ? Text.AlignHCenter : Text.AlignLeft
			verticalAlignment: Text.AlignVCenter
			color: root.textColor
			font.family: Configs.Fonts.fontFamily
			text: root.text
			Layout.fillHeight: true
			Layout.fillWidth: root.icon === ""
			visible: root.text !== ""
			font.pointSize: root.textSize
		}
		Item {
			Layout.fillWidth: true
		}
	}


    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: !root.disabled ? Qt.PointingHandCursor : root.disabledCursor
		enabled: !root.disabled
        onClicked: (mouse) => {
            root.clicked(mouse)
        }
		acceptedButtons: root.acceptedButtons
        onPressedChanged: {
            // console.log(mouseArea.pressed)
            if (mouseArea.pressed) {
                root.scale = 0.9
            }
            else {
                root.scale = 1
            }
        }
    }

    HoverHandler {
        id: hoverHandler
		enabled: !root.disabled
    }
}

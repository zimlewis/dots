import QtQuick
import qs.modules.statusbar.modules
import qs.components as Components

BaseModule {
    id: root

	Components.Button {
		anchors.fill: parent
		width: 15
		icon: "update"
		variant: Components.Button.ButtonVariant.Ghost
	}

}


import QtQuick
import QtQuick.Layouts

import qs.modules.statusbar.modules.battery.inner
import qs.modules.statusbar.modules
import qs.components as Components
import qs.services as Services

BaseModule {
    id: root

    Layout.fillHeight: true
    Layout.preferredWidth: 25

	Components.Button {
		id: button
		anchors.fill: parent
		icon: Services.UPower.displayIcon
		buttonRadius: width / 2
		anchors.margins: 2
		variant: Components.Button.ButtonVariant.Ghost

		onClicked: mouse => {
			if (mouse.button === Qt.LeftButton) {
				const middleX = root.mapToGlobal(0, 0).x + root.width / 2;
				const middleY = 200 / 2;
				root.pop(middleX, middleY, 300, 200, popup, root.popupId);
			}
		}
	}


    Component {
        id: popup
        Popup {}
    }
}

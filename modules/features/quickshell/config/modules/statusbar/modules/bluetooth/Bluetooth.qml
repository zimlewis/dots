import QtQuick
import QtQuick.Layouts

import qs.modules.statusbar.modules
import qs.modules.statusbar.modules.bluetooth.inner
import qs.components as Components

BaseModule {
    id: root

    Components.Button {
        anchors.fill: parent
        Layout.fillWidth: true
        Layout.fillHeight: true
        variant: Components.Button.ButtonVariant.Ghost
        id: button
        width: 20
		icon: "bluetooth"

        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) {
                const x = root.mapToGlobal(0, 0).x + root.width / 2;
				const y = 200 / 2
                root.pop(x, y, 300, 200, popup, root.popupId)
            } 
        }
    }

    Component {
        id: popup
        Popup {
        }
    }
}

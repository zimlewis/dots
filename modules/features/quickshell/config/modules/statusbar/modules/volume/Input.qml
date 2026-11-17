import QtQuick
import QtQuick.Layouts

import qs.components as Components
import qs.modules.statusbar.modules.volume.inner
import qs.modules.statusbar.modules

BaseModule {
    id: root
    width: 20
    Layout.fillHeight: true

    Components.Button {
        anchors.fill: parent
        Layout.fillWidth: true
        Layout.fillHeight: true
        variant: Components.Button.ButtonVariant.Ghost
        id: button
		icon: "mic"

        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) {
                const x = root.mapToGlobal(0, 0).x + root.width / 2;
				const y = 200 / 2;
                root.pop(x, y, 500, 200, popup, root.popupId)
            } 
        }
    }

    Component {
        id: popup
        InputPopup { }
    }
}

pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.modules.statusbar.modules
import qs.modules.statusbar.modules.network.inner
import qs.services as Services
import qs.components as Components


BaseModule {
    id: root
    width: 20
    Layout.fillHeight: true
    readonly property var networkService: Services.Network

    Components.Button {
        anchors.fill: parent
        Layout.fillWidth: true
        Layout.fillHeight: true
        variant: Components.Button.ButtonVariant.Ghost
        id: button
        icon: root.networkService.statusIcon
		// text: root.networkService.ipAddress

        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) {
                const x = root.mapToGlobal(0, 0).x + root.width / 2;
				const y = 250;
                root.pop(x, y, 300, 500, popup, root.popupId)
            } 
        }
    }

    Component {
        id: popup
        Popup {
        }
    }
}

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.modules.statusbar.modules
import qs.modules.statusbar.modules.clock.inner
import qs.components as Components


BaseModule {
    id: root
    Layout.fillHeight: true



    Components.Button {
        id: button
        anchors.fill: parent
        variant: Components.Button.ButtonVariant.Ghost
        width: 90
        text: Qt.formatDateTime(new Date(), "ddd HH:mm:ss")

        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) {
                const x = root.mapToGlobal(0, 0).x + root.width / 2;
				const y = 350 / 2;
                root.pop(x, y, 500, 350, clockPopup, root.popupId)
            } 
        }

        // Text {
        //     text: Qt.formatDateTime(new Date(), "ddd HH:mm:ss")
        //     id: text
        //     horizontalAlignment: Text.AlignHCenter
        //     verticalAlignment: Text.AlignVCenter
        //     anchors.fill: parent
        //     color: Theme.foregroundPrimary
        //     font.family: Theme.fontFamily
        // }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: button.text = Qt.formatDateTime(new Date(), "ddd HH:mm:ss")
        }
    }

    Component {
        id: clockPopup
        Popup {}
    }

}

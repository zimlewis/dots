pragma ComponentBehavior: Bound
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.modules.statusbar.modules.tomato.inner
import qs.modules.statusbar.modules
import qs.components as Components


BaseModule {
    property string currentSession
    property string timeLeft

    id: root
    width: 100
    Layout.fillHeight: true

    Components.Button {
        anchors.fill: parent
        Layout.fillWidth: true
        Layout.fillHeight: true
        variant: Components.Button.ButtonVariant.Ghost
        id: button

        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) {
                const x = button.mapToGlobal(0, 0).x + button.width / 2;
				const y = 200 / 2;
                root.pop(x, y, 300, 200, tomatoPopup, root.popupId)
            } 
        }
    }


    Component {
        id: tomatoPopup
        Popup {
            currentSession: root.currentSession
            timeLeft: root.timeLeft
            onControlPress: {
                tomato.running = false
                tomato.running = true
            }
        }
    }



    Process {
        id: tomato
        command: ["tomato", "current", "-f", "basic"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                var p = data.trim().split(' ')
                button.text = p.length < 3
                    ? "POMO 25:00"
                    : "🍅 " + p[0].substring(0, 4).toUpperCase() + " " + p[1] + ":" + p[2];

                root.currentSession = p[0]
                root.timeLeft = p[1] + ":" + p[2];
            }
        }
    }
}

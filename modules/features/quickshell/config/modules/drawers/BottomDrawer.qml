import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.modules.popupcontainer
import qs.services as Services
import qs.configs

PanelWindow {
    id: root
    property real popupWidth: 400
    property real popupHeight: 400

    anchors {
        left: true
        bottom: true
        right: true
    }
    margins {
        bottom: 0
        left: 10
        right: 10
    }
    exclusiveZone: 0
    implicitHeight: 2
    color: "transparent"

    Item {
        anchors.fill: parent
        MouseArea {
            anchors.fill: parent
            onClicked: mouse => {
                const x = mouse.x;
                Services.PopupController.togglePopup(x, -1, root.popupWidth, root.popupHeight, popup, "bottomDrawer");
            }
            cursorShape: Qt.PointingHandCursor
        }
    }

    Component {
        id: popup

        BasePopup {
			ColumnLayout {
                anchors.fill: parent
				Rectangle {
					color: Colors.surfaceMuted
					Layout.fillWidth: true
					Layout.preferredHeight: 50

					Text {
						text: "text"
						color: Colors.surfaceFg
					}

				}

				Rectangle {
					color: Colors.surface
					Layout.fillWidth: true
					Layout.preferredHeight: 50

					Text {
						text: "text"
						color: Colors.surfaceVariantFg
					}

				}
			}
        }
    }
}

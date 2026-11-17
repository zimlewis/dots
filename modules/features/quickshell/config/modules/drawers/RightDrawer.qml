import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services as Services
import qs.configs as Configs
import qs.modules.drawers.modules.tray
import qs.modules.drawers.modules.notification
import qs.modules.drawers.modules.session
import qs.modules.popupcontainer
 

PanelWindow {
    property real popupWidth: 350
	property real popupHeight: height


    anchors { 
        top: true
        right: true
        bottom: true 
    }
    margins { 
        top: 5
        bottom: 5
        right: 0
    }
    exclusiveZone: 0
    id: root
    implicitWidth: 5
    color: "transparent"



    Item {
        anchors.fill: parent
        MouseArea {
            anchors.fill: parent
            onClicked: {
				const y = root.height / 2; 
				Services.PopupController.togglePopup(-1, y, root.popupWidth, root.popupHeight, popup, "rightDrawer")
            }
            cursorShape: Qt.PointingHandCursor
        }

    }


	Component {
		id: popup
		
		BasePopup {
			anchors.fill: parent
			Item {
				anchors.fill: parent
				ColumnLayout {
					anchors.fill: parent
					Notification {
						Layout.fillWidth: true
						Layout.fillHeight: true
					}
					Item {
						height: 1
						Layout.fillWidth: true
						Rectangle {
							color: Configs.Colors.outline
							anchors.fill: parent
							anchors.rightMargin: 10
							anchors.leftMargin: 10
						}
					}
					Tray {
						Layout.fillWidth: true
						Layout.fillHeight: true
					}
					Item {
						height: 1
						Layout.fillWidth: true
						Rectangle {
							color: Configs.Colors.outline
							anchors.fill: parent
							anchors.rightMargin: 10
							anchors.leftMargin: 10
						}
					}
					SessionManager {
						Layout.fillWidth: true
					}
				}
			}
		}
	}


}

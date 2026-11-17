import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.modules.drawers.modules.colormode
import qs.modules.popupcontainer
import qs.services as Services
import qs.configs as Configs

PanelWindow {
    property real popupWidth: 350
	property real popupHeight: height


    anchors { 
        top: true
        left: true
        bottom: true 
    }
    margins { 
        top: 5
        bottom: 5
        left: 0
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
				Services.PopupController.togglePopup(0, y, root.popupWidth, root.popupHeight, popup, "leftDrawer")
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
					ColorMode {
						Layout.fillWidth: true
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
					Item { Layout.fillHeight: true }
				}
			}
		}
	}
}

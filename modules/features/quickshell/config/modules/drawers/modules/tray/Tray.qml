import Quickshell.Services.SystemTray 
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.modules.drawers.modules.tray.inner

Item {
    id: root

	ListView {
		anchors.fill: parent
		anchors.leftMargin: 15
		anchors.rightMargin: 15

		clip: true
		model: SystemTray.items

		spacing: 10
		delegate: TrayItem {
			required property var modelData
			item: modelData
		}

		add: Transition {
			ParallelAnimation {
				NumberAnimation {
					properties: "opacity"
					from: 0
					to: 1
					duration: 200
					easing.type: Easing.InCubic
				}
			}
		}

		remove: Transition {
			ParallelAnimation {
				NumberAnimation { 
					property: "opacity"
					to: 0
					duration: 100
				}
			}
		}

		removeDisplaced: Transition {
			NumberAnimation { 
				properties: "y"
				duration: 100
			}
		}

		addDisplaced: Transition {
			NumberAnimation {
				properties: "y"
				duration: 100
			}
		}
	}

}


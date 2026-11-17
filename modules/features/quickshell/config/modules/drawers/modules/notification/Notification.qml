import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.modules.drawers.modules.notification.inner
import qs.services as Services
import qs.configs as Configs
import qs.components as Components


Item {
    id: root

    property var notifService: Services.Notifications
	ColumnLayout {
		anchors.fill: parent
		Item {
			Layout.preferredHeight: 50
			Layout.fillWidth: true

			RowLayout {
				anchors.fill: parent
				anchors.leftMargin: 15
				anchors.rightMargin: 15
				anchors.topMargin: 10

				Text {
					verticalAlignment: Text.AlignVCenter
					font.family: Configs.Fonts.fontFamily
					color: Configs.Colors.surfaceFg

					Layout.fillHeight: true
					text: {
						const count = root.notifService.list.count
						return `${count !== 0 ? count : "No"} notification${count != 1 ? "s" : ""}`
					}
				}

				Item {
					Layout.fillWidth: true
				}

				Components.Button {
					Layout.fillHeight: true
					Layout.preferredWidth: height
					buttonRadius: width / 2
					variant: Components.Button.ButtonVariant.Ghost
					togglable: true
					icon: "bottom_sheets"
					onActivatedChanged: {
						root.notifService.toastEnable = activated
					}
					
					Component.onCompleted: {
						activated = root.notifService.toastEnable
					}

				}

				Components.Button {
					Layout.fillHeight: true
					Layout.preferredWidth: height
					buttonRadius: width / 2
					variant: Components.Button.ButtonVariant.Ghost
					togglable: true
					icon: "notifications"
					onActivatedChanged: {
						root.notifService.notificationSound = activated
					}

					Component.onCompleted: {
						activated = root.notifService.notificationSound
					}
				}

				Components.Button {
					Layout.fillHeight: true
					Layout.preferredWidth: height
					buttonRadius: width / 2
					icon: "data_check"
					variant: Components.Button.ButtonVariant.Ghost
					bgColor: Configs.Colors.surfaceMuted
					onClicked: Services.Notifications.discardAllNotifications()
					disabled: root.notifService.list.count === 0
				}
			}
		}

		ListView {
			Layout.fillWidth: true
			Layout.fillHeight: true
			clip: true
			spacing: 5

			model: root.notifService.list
			delegate: NotificationItem {
				required property var modelData
				notif: modelData
				anchors.left: parent.left
				anchors.right: parent.right
				anchors.leftMargin: 15
				anchors.rightMargin: 15
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

		// ScrollView {
		// 	Layout.fillWidth: true
		// 	Layout.fillHeight: true
		// 	ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
		//
		// 	contentWidth: availableWidth
		// 	RowLayout {
		// 		implicitHeight: col.implicitHeight
		// 		anchors.top: parent.top
		// 		anchors.left: parent.left
		// 		anchors.right: parent.right
		// 		clip: true
		// 		Item {
		// 			width: 10
		// 		}
		// 		ColumnLayout {
		// 			id: col
		// 			anchors.topMargin: 10
		// 			anchors.bottomMargin: 10
		//
		// 			Item {
		// 				width: 10
		// 				height: 4
		// 			}
		//
		// 			Repeater {
		// 				model: root.notifService.list
		// 				delegate: NotificationItem {
		// 					required property var modelData
		// 					notif: modelData
		// 				}
		// 			}
		//
		//
		// 			Item {
		// 				height: 20
		// 			}
		// 		}
		//
		// 		Item {
		// 			width: 10
		// 		}
		// 	}
		// }
	}

}


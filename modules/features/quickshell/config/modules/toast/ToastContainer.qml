import Quickshell
import QtQuick

import qs.services as Services
import qs.components as Components
import qs

PanelWindow {
	id: root
	mask: Region {
		x: list.childrenRect.x
		y: list.childrenRect.y
		width: list.childrenRect.width
		height: list.childrenRect.height
	}

    readonly property var notificationsService: Services.Notifications
	readonly property bool notifPanelOpen: GlobalStates.currentPopup === "rightDrawer" && GlobalStates.popupOpen
	readonly property bool toastActivating: !notifPanelOpen && notificationsService.toastEnable

	onNotifPanelOpenChanged: {
		if (notifPanelOpen) {
			notifModel.clear()
		}
	}



    anchors { 
        top: true
        right: true
		bottom: true
    }
    margins { 
        top: 5
        right: 10
		bottom: 5
    }


	color: "transparent"

	exclusiveZone: 0
	width: 400


	ListModel { id: notifModel }

	ListView {
		id: list
		model: notifModel
		anchors.fill: parent
		clip: true

		spacing: 10
		delegate: ToastItem {

			required property Components.Notif modelData
			required property int index
			property real progress: 0


			id: toastItem

			remaining: progress
			imgReady: img.isReady
			imgSmall: img.isSmall
			imgSrc: img.source

			notif: modelData

			anchors.left: parent.left
			anchors.right: parent.right
			onCloseNotification: {
				notifModel.remove(index)
			}

			HoverHandler {
				id: hoverHandler
			}


			Image {
				readonly property bool isReady: status === Image.Ready
				readonly property bool isSmall: (width <= 400 && height <= 400)

				id: img
				source: modelData.image
				// source: Qt.resolvedUrl(Services.Directories.imgPath + '/t.png')
				visible: false
				layer.enabled: false
			}

			NumberAnimation {
				running: hoverHandler.hovered
				to: 0
				duration: 50
				target: toastItem
				property: "progress"
			}

			ParallelAnimation {
				id: waitAnimation
				running: !hoverHandler.hovered

				SequentialAnimation {
					NumberAnimation {
						from: 0
						to: 1
						duration: 3000
						target: toastItem
						property: "progress"
					}

					ScriptAction {
						script: {
							let idx = -1

							for (let i = 0; i < notifModel.count; i++) {
								if (notifModel.get(i).notif.notificationId === toastItem.notif.notificationId) {
									idx = i
								}
							}

							if (idx !== -1) {
								notifModel.remove(idx)
							}

							animRoot.destroy()
						}
					}
				}
			}


			Connections {
				target: modelData

				function onDiscard() {
					notifModel.remove(index)
				}
			}

			onDiscardNotification: {
				notifModel.remove(index)
				Services.Notifications.discardNotification(notif.notificationId)
			}
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

    Component {
        id: notifComponent
        Components.Notif {}
    }


	Connections {
		target: root.notificationsService

		function onNotificationRecieved(notif) {
			if (!root.toastActivating) { return }

			const newNotifObject = notifComponent.createObject(root, {
				"notificationId": notif.id + Services.Notifications.idOffset,
				"notification": notif,
				"time": Date.now(),
			});
			notifModel.insert(0, { "notif": newNotifObject });
			console.log(JSON.stringify(newNotifObject))

			// const newTimer = notifRemoveComponent.createObject(root, {
			// 	"notifId": notif.id + Services.Notifications.idOffset,
			// 	"wait": 3000
			// })
		}
	}

}

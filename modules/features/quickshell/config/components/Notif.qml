import QtQuick
import Quickshell.Services.Notifications
import qs.services as Services


QtObject {
	id: root
	signal discard()
	required property int notificationId // Could just be `id` but it conflicts with the default prop in QtObject
	property Notification notification
	property list<var> actions: notification?.actions
		.filter((action) => action.identifier !== "default")
		.map((action) => ({
			"identifier": action.identifier,
			"text": action.text,
		})) ?? []
	property bool hasDefaultAction: notification?.actions.find((action) => action.identifier === "default") !== undefined
	property bool isTransient: notification?.hints.transient ?? false
	property string appIcon: notification?.appIcon ?? ""
	property string appName: notification?.appName ?? ""
	property string body: notification?.body ?? ""
	property string image: notification?.image ?? ""
	property string summary: notification?.summary ?? ""
	property double time
	property string urgency: notification?.urgency.toString() ?? "normal"
	property Timer timer

	onNotificationChanged: {
		console.log(JSON.stringify(notification))
		if (notification === null) {
			root.discard()
			Services.Notifications.discardNotification(root.notificationId)
		}
	}
}

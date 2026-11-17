pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Io
import qs.services
import qs.components as Components

Singleton {
    id: root

	signal notificationRecieved(notif: Notification)

    property string filePath: Directories.notificationsPath

	property bool toastEnable: true
	property bool notificationSound: true

    readonly property alias list: notifModel
    property int idOffset: 0


	function stringifyList() {
		const arr = [];
		for (let i = 0; i < notifModel.count; i++) {
			arr.push(notifToJSON(notifModel.get(i).notif));
		}
		return JSON.stringify(arr, null, 2);
	}

	function discardAllNotifications() {	
		const l = notifModel.count
		for (let i = 0; i < l; i++) {
			const curr = notifModel.get(0).notif
			const currId = curr.notificationId
			const notifServerIndex = notifServer.trackedNotifications.values.findIndex(
				n => n.id + root.idOffset === currId
			)

			curr.destroy()
			notifModel.remove(0)

			if (notifServerIndex !== -1) {
				notifServer.trackedNotifications.values[notifServerIndex].dismiss();
			}
		}

		notificationFileView.setText(root.stringifyList());
	}

	function discardNotification(id) {
		console.log("[Notifications] Discarding notification with ID: " + id);

		let index = -1;
		for (let i = 0; i < notifModel.count; i++) {
			if (notifModel.get(i).notif.notificationId === id) {
				index = i;
				break;
			}
		}

		const notifServerIndex = notifServer.trackedNotifications.values
			.findIndex(n => n.id + root.idOffset === id);

		if (index !== -1) {
			notifModel.get(index).notif.destroy(); // cleanup the component instance
			notifModel.remove(index);              // only this delegate is destroyed
			notificationFileView.setText(root.stringifyList());
		}

		if (notifServerIndex !== -1) {
			notifServer.trackedNotifications.values[notifServerIndex].dismiss();
		}
	}

	function attemptInvokeAction(id, notifIdentifier) {
		const notifServerIndex = notifServer.trackedNotifications.values.findIndex((notif) => notif.id + root.idOffset === id);
        if (notifServerIndex !== -1) {
            const notifServerNotif = notifServer.trackedNotifications.values[notifServerIndex];
            const action = notifServerNotif.actions.find((action) => action.identifier === notifIdentifier);
            // console.log("Action found: " + JSON.stringify(action));
            action.invoke()
        } 
		else {
			console.log("Notification not found in server: " + id)
		}

		discardNotification(id)
	}

    function notifToJSON(notif) {
        return {
            "notificationId": notif.notificationId,
            "actions": notif.actions,
			"hasDefaultAction": notif.hasDefaultAction,
            "appIcon": notif.appIcon,
            "appName": notif.appName,
            "body": notif.body,
            "image": notif.image,
            "summary": notif.summary,
            "time": notif.time,
            "urgency": notif.urgency
        };
    }

	ListModel {
		id: notifModel
	}

    Component {
        id: notifComponent
        Components.Notif {}
    }

    Process {
        id: sound
        property string soundFile: "/usr/share/sounds/freedesktop/stereo/bell.oga"
        running: false
        command: ["paplay", "--volume=65536", soundFile]

        function play() {
            if (running) {
                running = false;
            }

            running = true;
        }
    }

    NotificationServer {
        id: notifServer
        actionsSupported: true
        bodyHyperlinksSupported: true
        bodyImagesSupported: true
        bodyMarkupSupported: true
        bodySupported: true
        imageSupported: true
        keepOnReload: false
        persistenceSupported: true

        onNotification: notif => {
			playNotificationSound(notif);
			notif.tracked = true;
			const newNotifObject = notifComponent.createObject(root, {
				"notificationId": notif.id + root.idOffset,
				"notification": notif,
				"time": Date.now()
			});
			notifModel.insert(0, { "notif": newNotifObject });
			notificationFileView.setText(root.stringifyList());
			root.notificationRecieved(notif)
        }

        function playNotificationSound(notif) {
            // Respect the suppress-sound hint from the sender
            if (notif.hints["suppress-sound"]?.value === true) return;

			if (!root.notificationSound) return;

            // Use sound-file hint if sender provided one
            const hintFile = notif.hints["sound-file"]?.value;
            if (hintFile) sound.soundFile = hintFile;

            sound.play();
        }
    }
    Component.onCompleted: {
        console.log("completed");
    }

    FileView {
        id: notificationFileView
        path: Qt.resolvedUrl(filePath)

        onLoaded: {
			// Destroy existing component instances before clearing
			for (let i = 0; i < notifModel.count; i++)
				notifModel.get(i).notif.destroy();
			notifModel.clear();

			const data = JSON.parse(notificationFileView.text());
			data.forEach(notif => {
				const obj = notifComponent.createObject(root, {
					"notificationId": notif.notificationId,
					"actions":   [],
					"hasDefaultAction": false,
					"appIcon":   notif.appIcon,
					"appName":   notif.appName,
					"body":      notif.body,
					"image":     notif.image,
					"summary":   notif.summary,
					"time":      notif.time,
					"urgency":   notif.urgency
				});
				notifModel.append({ "notif": obj });
			});

			let latestID = 0;
			for (let i = 0; i < notifModel.count; i++)
				latestID = Math.max(latestID, notifModel.get(i).notif.notificationId);

			console.log("[Notifications] File loaded");
			root.idOffset = latestID;
        }

        onLoadFailed: error => {
			if (error == FileViewError.FileNotFound) {
				console.log("[Notifications] File not found, creating new file.");
				notifModel.clear();
				notificationFileView.setText(root.stringifyList());
			} else {
				console.log("[Notifications] Error loading file: " + error);
			}
		};
    }
}

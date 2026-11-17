//@ pragma UseQApplication
// import Quickshell.Wayland
// import QtQuick.Layouts
//@ pragma IconTheme breeze
import Quickshell
import QtQuick

import qs.services as Services
import qs.modules.statusbar
import qs.modules.popupcontainer
import qs.modules.drawers
import qs.modules.toast
import Quickshell.Services.SystemTray

ShellRoot {
    id: root
    // Keeps the tray host alive from startup
    Item {
		id: serviceContainer
        readonly property var items: SystemTray.items
		readonly property var configService: Services.Configuration
		readonly property var dateTimeService: Services.DateTime
		readonly property var directoriesService: Services.Directories
		readonly property var loggerService: Services.Logger
		readonly property var networkService: Services.Network
		readonly property var notificationsService: Services.Notifications
		readonly property var popupControllerService: Services.PopupController
    }



    StatusBar {
        id: topBar

        Connections {
            target: serviceContainer.notificationsService

            function onNotificationRecieved(notif) {
                console.log(JSON.stringify(notif));
            }
        }
    }

	ToastContainer {

	}

    LeftDrawer {}
    RightDrawer {}
    BottomDrawer {}

    PopupContainer {}
}

pragma Singleton
pragma ComponentBehavior: Bound

import QtCore
import QtQuick
import Quickshell
import qs.utils

Singleton {
	readonly property string cache: StandardPaths.standardLocations(StandardPaths.CacheLocation)[0]
	readonly property string state: StandardPaths.standardLocations(StandardPaths.StateLocation)[0]

	property string configurationPath: FileUtils.trimFileProtocol(`${state}/configs.json`)
	
	property string notificationsPath: FileUtils.trimFileProtocol(`${cache}/notifications/notifications.json`)
	property string imgPath: Quickshell.shellPath("imgs")
	property string soundPath: Quickshell.shellPath("sound")
}

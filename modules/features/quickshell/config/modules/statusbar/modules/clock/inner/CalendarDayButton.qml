import qs.components as Components
import Quickshell
import QtQuick.Layouts
import QtQuick

Components.Button {
	id: root

	togglable: true
	activated: isToday
	
    Layout.fillWidth: false
    Layout.fillHeight: false
    implicitWidth: 38
    implicitHeight: 38

	property bool isToday
	property string day
	property bool bold

	text: day
}

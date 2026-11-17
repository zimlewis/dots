import QtQuick
import QtQuick.Layouts
import Quickshell.Io

import qs.components as Components
import qs.services as Services
import qs.configs as Configs

Item {
    height: 50
    RowLayout {
		anchors.fill: parent
		anchors.leftMargin: 20
		anchors.rightMargin: 20
		anchors.bottomMargin: 6
		anchors.topMargin: 6
		spacing: 4

		Text {
			Layout.fillWidth: true
			Layout.preferredHeight: parent.height
			verticalAlignment: Text.AlignVCenter
			color: Configs.Colors.surfaceVariantFg
			font.family: Configs.Fonts.fontFamily
			font.pointSize: 10
			text: `Up ${Services.DateTime.uptime}`
		}

		// Components.Button {
		// 	buttonRadius: parent.height / 2
		// 	Layout.preferredHeight: parent.height
		// 	Layout.preferredWidth: parent.height  // parent = RowLayout, height already resolved
		// 	text: ' '
		// }
		Item { Layout.fillWidth: true }  // pushes the three squares to the left
		Components.Button {
			buttonRadius: parent.height / 2
			Layout.preferredHeight: parent.height
			Layout.preferredWidth: parent.height  // parent = RowLayout, height already resolved
			icon: 'logout'
			iconSize: 9
			variant: Components.Button.ButtonVariant.Default
		}
		Components.Button {
			buttonRadius: parent.height / 2
			Layout.preferredHeight: parent.height
			Layout.preferredWidth: parent.height  // parent = RowLayout, height already resolved
			iconSize: 9
			icon: "bedtime"
			variant: Components.Button.ButtonVariant.Default
			onClicked: sleepCommand.running = true

			Process {
				id: sleepCommand
				command: ["systemctl", "suspend"]
			}
		}
		Components.Button {
			buttonRadius: parent.height / 2
			Layout.preferredHeight: parent.height
			Layout.preferredWidth: parent.height  // parent = RowLayout, height already resolved
			variant: Components.Button.ButtonVariant.Default
			onClicked: shutdownCommand.running = true
			Process {
				id: shutdownCommand
				command: ["shutdown", "now"]
			}
			icon: "power_settings_new"
			iconSize: 9
		}

    }
}

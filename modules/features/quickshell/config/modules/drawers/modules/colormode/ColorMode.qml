import QtQuick
import QtQuick.Layouts

import qs.components as Components
import qs.services as Services

Item {
    height: 50
    RowLayout {
		anchors.fill: parent
		anchors.leftMargin: 20
		anchors.rightMargin: 20
		anchors.topMargin: 10
		spacing: 4

		Item { Layout.fillWidth: true }  // pushes the three squares to the left
		Components.Button {
			buttonRadius: parent.height / 2
			Layout.preferredHeight: parent.height
			Layout.preferredWidth: parent.height  // parent = RowLayout, height already resolved
			icon: {
				if (Services.Configuration.configs.colorMode == Components.Configurations.ColorMode.Light) {
					return 'dark_mode'
				}
				else {
					return 'light_mode'
				}
			}
			variant: Components.Button.ButtonVariant.Secondary
			onClicked: {
				if (Services.Configuration.configs.colorMode == Components.Configurations.ColorMode.Light) {
					Services.Configuration.configs.colorMode = Components.Configurations.ColorMode.Dark
				}
				else {
					Services.Configuration.configs.colorMode = Components.Configurations.ColorMode.Light
				}
				Services.Configuration.saveConfig()
			}
		}
    }
}

pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

import qs.components as Components
import qs.services as Services

Singleton {
	id: root
	property Components.Configurations configs
    property string filePath: Services.Directories.configurationPath

	Component.onCompleted: {
	}


	function configsToJSON() {
		return {
			borderRadius: root.configs.borderRadius,
			colorMode: root.configs.colorMode,
			fontFamily: root.configs.fontFamily,
			fontSizeSmall: root.configs.fontSizeSmall,
			fontSizeNormal: root.configs.fontSizeNormal,
			fontSizeLarge: root.configs.fontSizeLarge
		}
	}

	function defaultConfig() {
		return configComponent.createObject(root, {
			borderRadius: 3,
			colorMode: Components.Configurations.ColorMode.Dark,

			fontFamily: "CaskaydiaMono Nerd Font",
			fontSizeSmall: 7,
			fontSizeNormal: 11,
			fontSizeLarge: 24
		})
	}

	Component {
		id: configComponent

		Components.Configurations {}
	}

	function saveConfig() {
		configurationFileView.setText(JSON.stringify(root.configsToJSON(), null, 2));
	}


	FileView {
        id: configurationFileView
        path: Qt.resolvedUrl(root.filePath)


        onLoaded: {
			const data = JSON.parse(configurationFileView.text());
			const configObj = configComponent.createObject(root, {
				borderRadius: data.borderRadius,
				colorMode: data.colorMode,

				fontFamily: data.fontFamily,
				fontSizeSmall: data.fontSizeSmall,
				fontSizeNormal: data.fontSizeNormal,
				fontSizeLarge: data.fontSizeLarge
			})

			root.configs = configObj
        }

        onLoadFailed: error => {
			if (error == FileViewError.FileNotFound) {
				console.log("[Configurations] File not found, creating new file.");
				const defaultConfig = root.defaultConfig()
				root.configs = defaultConfig

				root.saveConfig()
			}
			else {
				console.log("[Configurations] Error loading file: " + error);
			}
		};
	}
}

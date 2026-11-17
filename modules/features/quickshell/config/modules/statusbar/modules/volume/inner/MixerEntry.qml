import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire

import qs.configs as Configs
import qs.components as Components

ColumnLayout {
	required property PwNode node;
    property string mutedIcon: "volume_off"
    property string icon: "volume_up"
	id: root

	// bind the node so we can read its properties
	PwObjectTracker { objects: [ root.node ] }

	RowLayout {
        Item {
            clip: true
            Layout.fillWidth: true
            Layout.fillHeight: true
            Label {
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
                text: {
                    // application.name -> description -> name
                    const app = root.node.properties["application.name"] ?? (node.description != "" ? node.description : node.name);
                    const media = root.node.properties["media.name"];
                    return media != undefined ? `${app} - ${media}` : app;
                }
                color: Configs.Colors.surfaceFg
            }
        }
        Components.Button {
            width: 50
            height: 20
            icon: root.node.audio.muted ? root.mutedIcon : root.icon
            variant: Components.Button.ButtonVariant.Ghost
			onClicked: root.node.audio.muted = !root.node.audio.muted
        }

	}

	RowLayout {
		Components.Slider {
			Layout.fillWidth: true
            implicitHeight: 24
			value: root.node.audio.volume
			onValueChanged: root.node.audio.volume = value
            to: 1.5
		}
	}
}

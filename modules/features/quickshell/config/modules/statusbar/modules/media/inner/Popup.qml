import QtQuick

import QtQuick.Controls
import QtQuick.Layouts

import Quickshell.Services.Mpris

import qs.modules.popupcontainer
import qs.services as Services
import qs.configs as Configs
import qs.components as Components

BasePopup {
	property string trackedPlayerId: Services.Media.trackedPlayerId


	onOpen: {	
		const idx = Services.Media.trackedPlayerIndex
		if (idx === -1) { return }
		list.currentIndex = idx
		list.positionViewAtIndex(idx, ListView.Beginning)
	}

    Item {
        anchors.fill: parent
        anchors.topMargin: 8
        anchors.bottomMargin: 8
        Text {
            text: "Nothing is playing"
            font.family: Configs.Fonts.fontFamily
            font.pointSize: 15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.fill: parent
            visible: Services.Media.players.values.length === 0
            color: Configs.Colors.surfaceFg
        }
	
		RowLayout {
			anchors.fill: parent
			anchors.leftMargin: 5
			anchors.rightMargin: 5
			spacing: 1
			visible: Services.Media.players.values.length !== 0
			Item {
				Layout.preferredWidth: 25
				Layout.fillHeight: true
				opacity: (list.currentIndex > 0) ? 1 : 0.5

				Components.Button {
					anchors.fill: parent
					variant: Components.Button.ButtonVariant.Ghost
					z: 1
					text: "<"
					disabled: !(list.currentIndex > 0)
					bgColor: Configs.Colors.surfaceMuted

					onClicked: {
						list.currentIndex -= 1
					}
				}
			}
			ListView {
				id: list
				Layout.fillWidth: true
				Layout.fillHeight: true


				model: Services.Media.players
				clip: true

				orientation: ListView.Horizontal
				snapMode: ListView.SnapOneItem
				highlightRangeMode: ListView.StrictlyEnforceRange
				highlightMoveDuration: 300  // ms
				highlightMoveVelocity: -1   // -1 = use duration instead of velocity

				ScrollBar.vertical: ScrollBar {
					policy: ScrollBar.AlwaysOff
				}
				ScrollBar.horizontal: ScrollBar {
					policy: ScrollBar.AlwaysOff
				}
				delegate: MediumController {
					required property MprisPlayer modelData

					player: modelData

					width: ListView.view.width
					height: ListView.view.height
				}
			}
			Item {
				Layout.preferredWidth: 25
				Layout.fillHeight: true
				opacity: (list.currentIndex < Services.Media.players.values.length - 1) ? 1 : 0.5

				Components.Button {
					anchors.fill: parent
					variant: Components.Button.ButtonVariant.Ghost
					z: 1
					text: ">"
					disabled: !(list.currentIndex < Services.Media.players.values.length - 1)
					bgColor: Configs.Colors.surfaceMuted

					onClicked: {
						list.currentIndex += 1
					}
				}
			}
		}
    }
}

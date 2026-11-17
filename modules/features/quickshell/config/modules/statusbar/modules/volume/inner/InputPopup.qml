import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import qs.modules.statusbar.modules.volume.inner
import qs.configs as Configs
import qs.modules.popupcontainer

BasePopup {
    Item {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 10
        anchors.bottomMargin: 10

		PwNodeLinkTracker {
			id: linkTracker
			node: Pipewire.defaultAudioSource
		}

		ColumnLayout {
			anchors.fill: parent

			MixerEntry {
				icon: "mic"
				mutedIcon: "mic_off"
				node: Pipewire.defaultAudioSource
				Layout.fillWidth: true
				Layout.fillHeight: false
			}

			Rectangle {
				Layout.fillWidth: true
				color: Configs.Colors.outline
				Layout.preferredHeight: 1
			}

			Item {
				Layout.fillWidth: true
				Layout.fillHeight: true
				ListView {
					model: linkTracker.linkGroups
					anchors.fill: parent
					anchors.topMargin: 5
					clip: true
					contentWidth: availableWidth


					delegate: MixerEntry {
						icon: "mic"
						mutedIcon: "mic_off"
						required property PwLinkGroup modelData
						node: modelData.target
					}

					add: Transition {
						ParallelAnimation {
							NumberAnimation {
								properties: "opacity"
								from: 0
								to: 1
								duration: 200
								easing.type: Easing.InCubic
							}
						}
					}

					remove: Transition {
						ParallelAnimation {
							NumberAnimation { 
								property: "opacity"
								to: 0
								duration: 100
							}
						}
					}

					removeDisplaced: Transition {
						NumberAnimation { 
							properties: "y"
							duration: 100
						}
					}

					addDisplaced: Transition {
						NumberAnimation {
							properties: "y"
							duration: 100
						}
					}
				}
			}


		}

    }
}


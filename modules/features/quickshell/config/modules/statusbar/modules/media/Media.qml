import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import qs.modules.statusbar.modules
import qs.modules.statusbar.modules.media.inner

import qs.services as Services
import qs.components as Components
import qs.configs as Configs

BaseModule {
    id: root

    Components.Button {
        id: area
        width: Math.min(txt.implicitWidth, 100)
        clip: true
        variant: Components.Button.ButtonVariant.Ghost
		acceptedButtons: Qt.LeftButton | Qt.RightButton

        anchors.fill: parent
        onClicked: mouse => {
			if (mouse.button === Qt.LeftButton) {
				const x = area.mapToGlobal(0, 0).x + area.width / 2;
				const y = 150 / 2;
				root.pop(x, y, 450, 150, popup, root.popupId)
			}
			else if (mouse.button === Qt.RightButton) {
				if (Services.Media.trackedPlayer === null) { return }
				if (!Services.Media.trackedPlayer.canTogglePlaying) { return }
				Services.Media.trackedPlayer.isPlaying = !Services.Media.trackedPlayer.isPlaying
			}

        }

        Item {
            visible: false
            id: contentNothingPlaying
            anchors.fill: parent

			Text {
				verticalAlignment: Text.AlignVCenter           
				anchors.fill: parent

				color: Configs.Colors.surfaceFg
				font.family: Configs.Fonts.fontFamily
				text: "Nothing is playing"
			}
        }

        Item {
            visible: false
            id: content
            anchors.fill: parent

            RowLayout {
                anchors.fill: parent
				visible: true

                Text {
                    verticalAlignment: Text.AlignVCenter           
                    Layout.fillHeight: true

                    id: icon
                    color: Configs.Colors.surfaceFg
                    font.family: Configs.Fonts.iconFamily
					font.pointSize: 11

					text: {
						if (Services.Media.trackedPlayer) {
							return Services.Media.trackedPlayer.isPlaying ? "pause" : "play_arrow"
						}

						return "play_arrow"
					}
                }
                Text {
                    verticalAlignment: Text.AlignVCenter           
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    id: txt
                    color: Configs.Colors.surfaceFg 
                    font.family: Configs.Fonts.fontFamily
					text: {
						if (Services.Media.trackedPlayer) {
							return Services.Media.trackedPlayer.trackTitle
						}
						return "Something is playing"
					}
                }

            }
        }



        OpacityMask {
            anchors.fill: content
            source: Services.Media.trackedPlayer !== null ? content : contentNothingPlaying
            maskSource: Rectangle {
                width: content.width
                height: content.height
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    // GradientStop { position: 0; color: "white" }
                    GradientStop { position: 0.7; color: "white" }  // fully visible
                    GradientStop { position: 1; color: "transparent" } // faded
                }
                visible: true
            }
        }

    }

    Component {
        id: popup
        Popup {
        }
    }


}





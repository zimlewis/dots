pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Qt5Compat.GraphicalEffects

import qs.components as Components
import qs.configs as Configs
import qs.services as Services

Item {
	required property MprisPlayer player

	id: root
	Layout.fillWidth: true
	Layout.preferredHeight: 140

	HoverHandler {
		id: area

		cursorShape: Qt.OpenHandCursor
	}


	Rectangle {
		anchors.fill: parent
		anchors.leftMargin: 4
		anchors.rightMargin: 4
		color: area.hovered ? Configs.Colors.surfaceMuted : Qt.rgba(
			Configs.Colors.surfaceMuted.r, Configs.Colors.surfaceMuted.g, Configs.Colors.surfaceMuted.b, 0
		)
		radius: Services.Configuration.configs.borderRadius
		clip: true

		Behavior on color {
			ColorAnimation {
				duration: 300
				easing.type: Easing.OutCubic
			}
		}

		Item {
			anchors.fill: parent
			anchors.margins: 10

			RowLayout {
				anchors.fill: parent
				spacing: 10

				Components.Button {
					Layout.fillHeight: true
					Layout.preferredWidth: height
					variant: Components.Button.ButtonVariant.Ghost
					onClicked: {
						Services.Media.trackedPlayerId = root.player.dbusName
					}

					Image {
						id: img
						anchors.fill: parent
						source: root.player.trackArtUrl
						antialiasing: true

						fillMode: Image.PreserveAspectCrop
						visible: false

						onStatusChanged: {
							if (status !== 1) {
								source = Qt.resolvedUrl(Services.Directories.imgPath + '/play.svg')
							}
						}
					}

					OpacityMask {
						anchors.fill: img
						source: img
						maskSource: Rectangle {
							width: trackTitle.width
							height: width
							radius: width / 2

						}
					}
				}

				ColumnLayout {
					Layout.fillHeight: true
					Layout.fillWidth: true

					RowLayout {
						Item {
							Layout.fillWidth: true
							Layout.preferredHeight: trackTitle.font.pointSize * 1.5 + 10
							clip: true

							Text {
								id: trackTitle
								anchors.left: parent.left
								anchors.right: parent.right
								anchors.top: parent.top
								anchors.bottom: parent.bottom

								text: root.player.trackTitle 
								color: Configs.Colors.surfaceFg
								font.pointSize: 11
								font.bold: true
								font.family: Configs.Fonts.fontFamily
								verticalAlignment: Text.AlignVCenter

								property bool isClipping: implicitWidth > parent.width
								visible: !isClipping
							}

							OpacityMask {
								anchors.fill: trackTitle
								source: trackTitle 
								maskSource: Rectangle {
									width: trackTitle.width
									height: trackTitle.height
									gradient: Gradient {
										orientation: Gradient.Horizontal
										// GradientStop { position: 0; color: "white" }
										GradientStop { position: 0.7; color: "white" }  // fully visible
										GradientStop { position: 1; color: "transparent" } // faded
									}
								}
								visible: trackTitle.isClipping
							}
						}
						Item {
							Layout.preferredHeight: trackTitle.font.pointSize * 1.5 + 10
							Layout.preferredWidth: trackTitle.font.pointSize * 1.5 + 10
							visible: root.player.loopSupported

							Components.Button {
								buttonRadius: width / 2
								anchors.fill: parent

								variant: Components.Button.ButtonVariant.Ghost
								icon: {
									if (root.player.loopState === MprisLoopState.None) return "repeat"
									if (root.player.loopState === MprisLoopState.Track) return "repeat_one_on"
									if (root.player.loopState === MprisLoopState.Playlist) return "repeat_on"
								}
								onClicked: {
									if (root.player.loopSupported) {
										root.player.loopState = (root.player.loopState + 1) % 3
									}
								}
							}
						}
					}



					RowLayout {
						Layout.fillWidth: true

						Item {
							Layout.fillWidth: true
							Layout.preferredHeight: artistTitle.font.pointSize * 1.5
							clip: true

							Text {
								id: artistTitle
								property bool isClipping: implicitWidth > parent.width
								anchors.left: parent.left
								anchors.right: parent.right
								text: root.player.trackArtist

								font.family: Configs.Fonts.fontFamily
								color: Configs.Colors.surfaceFg
								visible: !isClipping
							}


							OpacityMask {
								anchors.fill: artistTitle
								source: artistTitle
								maskSource: Rectangle {
									width: artistTitle.width
									height: artistTitle.height
									gradient: Gradient {
										orientation: Gradient.Horizontal
										// GradientStop { position: 0; color: "white" }
										GradientStop { position: 0.7; color: "white" }  // fully visible
										GradientStop { position: 1; color: "transparent" } // faded
									}
								}
								visible: artistTitle.isClipping
							}

						}

						Item {
							Layout.preferredWidth: playerPosition.implicitWidth
							Layout.preferredHeight: playerPosition.font.pointSize * 1.5
							Text {
								id: playerPosition							

								font.family: Configs.Fonts.fontFamily
								text: {
									const length = Math.floor(root.player.length)
									const position = Math.floor(root.player.position)

									const lengthMinute = Math.floor(length / 60)
									const lengthSecond = length % 60

									const positionMinute = Math.floor(position / 60)
									const positionSecond = position % 60

									return `${positionMinute < 10 ? 0 : ''}${positionMinute}:${positionSecond < 10 ? 0 : ''}${positionSecond} / ${lengthMinute < 10 ? 0 : ''}${lengthMinute}:${lengthSecond < 10 ? 0 : ''}${lengthSecond}` 
								}
								color: Configs.Colors.surfaceFg
								horizontalAlignment: Text.AlignRight
							}
						}

					}



					Item {
						Layout.fillWidth: true
						Layout.fillHeight: true

						ColumnLayout {
							anchors.fill: parent

							Components.Slider {
								implicitHeight: 24
								Layout.fillWidth: true
								to: root.player.length
								value: root.player.position
								showValue: false
								

								onMoved: {
									if (root.player.canSeek && root.player.positionSupported) {
										root.player.position = value
									}
								}
							}

							Item {
								Layout.fillWidth: true
								Layout.fillHeight: true
								RowLayout {
									anchors.left: parent.left
									anchors.right: parent.right
									height: 30
									anchors.verticalCenter: parent.verticalCenter
									Item {
										Layout.fillWidth: true
									}

									Item {
										Layout.preferredWidth: height
										Layout.fillHeight: true

										Components.Button {
											buttonRadius: width / 2
											anchors.fill: parent

											variant: Components.Button.ButtonVariant.Ghost
											icon: "skip_previous"
											onClicked: {
												if (root.player.canGoPrevious) {
													root.player.previous()
												}
											}
										}
									}
									Item {
										Layout.preferredWidth: height
										Layout.fillHeight: true

										Components.Button {
											buttonRadius: width / 2
											anchors.fill: parent

											variant: Components.Button.ButtonVariant.Outline
											icon: "fast_rewind"

											onClicked: {
												if (root.player.canSeek) {
													root.player.seek(-5000)
												}
											}
										}
									}
									Item {
										Layout.preferredWidth: height
										Layout.fillHeight: true

										Components.Button {
											buttonRadius: width / 2
											anchors.fill: parent

											icon: root.player.isPlaying ? "pause" : "play_arrow"

											onClicked: {
												if (root.player.canTogglePlaying) {
													root.player.isPlaying = !root.player.isPlaying
												}
											}
										}
									}
									Item {
										Layout.preferredWidth: height
										Layout.fillHeight: true

										Components.Button {
											buttonRadius: width / 2
											anchors.fill: parent

											variant: Components.Button.ButtonVariant.Outline
											icon: "fast_forward"

											onClicked: {
												if (root.player.canSeek) {
													root.player.seek(5000)
												}
											}
										}
									}
									Item {
										Layout.preferredWidth: height
										Layout.fillHeight: true

										Components.Button {
											buttonRadius: width / 2
											anchors.fill: parent

											variant: Components.Button.ButtonVariant.Ghost
											icon: "skip_next"
											onClicked: {
												if (root.player.canGoNext) {
													root.player.next()
												}
											}
										}
									}

									Item {
										Layout.fillWidth: true
									}
								}
							}

						}
					}
				}
			}
		}

	}

	FrameAnimation {
		running: root.player.playbackState === MprisPlaybackState.Playing
		onTriggered: root.player.positionChanged()
	}

}

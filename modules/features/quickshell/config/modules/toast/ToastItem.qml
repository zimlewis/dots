pragma ComponentBehavior: Bound
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Layouts

import qs.components as Components
import qs.configs as Configs
import qs.services as Services

Item {
    required property Components.Notif notif
	property real wait: 3000
	property real remaining
	property real imgWidth: 400
	property real imgHeight: imgWidth * 3 / 4
	property bool imgReady
	property bool imgSmall
	property string imgSrc

	signal closeNotification()
	signal discardNotification()
	signal useAction()

	implicitHeight: rec.height

	id: root

	Rectangle {
		id: rec
		anchors.left: parent.left
		anchors.right: parent.right
        color: Configs.Colors.surfaceMuted
        radius: Services.Configuration.configs.borderRadius
		height: col.implicitHeight + 20

        border {
            color: Configs.Colors.outlineVariant
        }



		ColumnLayout {
			id: col
			anchors.verticalCenter: parent.verticalCenter
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.leftMargin: 10
			anchors.rightMargin: 10
			// Summary
			RowLayout {
				Layout.fillWidth: true
				Item {
					Layout.fillWidth: true
					Layout.preferredHeight: 30
					id: summaryWrapper

					RowLayout {
						id: summaryRow
						anchors.fill: parent
						property bool isClipping: parent.implicitWidth < implicitWidth
						visible: !isClipping
						IconImage {
							Layout.preferredWidth: height
							Layout.fillHeight: true

							source: root.notif.image
							visible: root.imgReady && root.imgSmall
						}

						Text {
							id: summaryText
							text: root.notif.summary
							color: Configs.Colors.surfaceFg
							font.family: Configs.Fonts.fontFamily
							font.bold: true
						}
					}

					OpacityMask {
						anchors.fill: summaryRow
						source: summaryRow
						maskSource: Rectangle {
							width: summaryRow.width
							height: summaryRow.height
							gradient: Gradient {
								orientation: Gradient.Horizontal
								// GradientStop { position: 0; color: "white" }
								GradientStop { position: 0.7; color: "white" }  // fully visible
								GradientStop { position: 1; color: "transparent" } // faded
							}
						}
						visible: summaryRow.isClipping
					}

				}
				

				Components.Button {
					Layout.preferredWidth: 20
					Layout.preferredHeight: 20
					text: "-"
					buttonRadius: 10
					bgColor: Configs.Colors.surface
					variant: Components.Button.ButtonVariant.Ghost
					onClicked: root.closeNotification()
				}

				Components.Button {
					Layout.preferredWidth: 20
					Layout.preferredHeight: 20
					text: "x"
					buttonRadius: 10
					bgColor: Configs.Colors.surface
					variant: Components.Button.ButtonVariant.Ghost
					onClicked: root.discardNotification()
				}
			}

			Rectangle {
				Layout.preferredHeight: 1
				Layout.fillWidth: true
				color: Configs.Colors.outline
				Rectangle {
					anchors.top: parent.top
					anchors.bottom: parent.bottom
					anchors.left: parent.left
					anchors.right: parent.right
					color: Configs.Colors.primary

					anchors.rightMargin: parent.width * root.remaining
				}
			}

			// The content
			ColumnLayout {
				Layout.fillWidth: true
				Components.Button {
					Layout.preferredHeight: 60
					Layout.fillWidth: true
					Layout.alignment: Qt.AlignTop
					variant: Components.Button.ButtonVariant.Ghost
					disabled: !root.notif.hasDefaultAction
					disabledOpacity: 1
					disabledCursor: Qt.ArrowCursor
					onClicked: {
						Services.Notifications.attemptInvokeAction(root.notif.notificationId, "default")
					}

					clip: true
					Text {
						property bool isClipping: implicitHeight > parent.height
						id: body
						anchors.fill: parent
						verticalAlignment: isClipping ? Text.AlignTop : Text.AlignVCenter
						text: root.notif.body
						color: Configs.Colors.surfaceFg
						font.family: Configs.Fonts.fontFamily
						wrapMode: Text.WordWrap
						visible: !isClipping
					}

					OpacityMask {
						anchors.fill: body
						source: body 
						maskSource: Rectangle {
							width: body.width
							height: body.height
							gradient: Gradient {
								orientation: Gradient.Vertical
								// GradientStop { position: 0; color: "white" }
								GradientStop { position: 0.7; color: "white" }  // fully visible
								GradientStop { position: 1; color: "transparent" } // faded
							}
						}
						visible: body.isClipping
					}
				}

				// Where image will be if it large
				
				Item {
					Layout.fillWidth: true
					Layout.preferredHeight: root.imgHeight

					visible: root.imgReady && !root.imgSmall

					Image {
						anchors.fill: parent
						source: root.imgSrc
						sourceSize.width: width
						sourceSize.height: height
						fillMode: Image.PreserveAspectFit
					}
				}



				// Action
				RowLayout {
					Layout.fillWidth: true

					Repeater {
						model: root.notif.actions
						delegate: Item {
							required property var modelData
							Layout.preferredHeight: 40
							Layout.fillWidth: true
							Components.Button {
								anchors.fill: parent
								text: parent.modelData.text
								Layout.fillWidth: true
								variant: Components.Button.ButtonVariant.Ghost
								bgColor: Configs.Colors.surface
								onClicked: {
									root.useAction()
									Services.Notifications.attemptInvokeAction(root.notif.notificationId, parent.modelData.identifier)
								}
							}
						}
					}
				}
			}
		}

	}
}

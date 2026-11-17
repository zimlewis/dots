pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import qs.components as Components
import qs.services as Services
import qs.configs as Configs

RowLayout {
    id: root
    required property var notif
	clip: true
	Layout.preferredWidth: 200




    Components.Dropdown {
		id: mainDropdown
		bgColor: expanded ? Configs.Colors.surfaceMuted : Qt.rgba(
			Configs.Colors.surfaceMuted.r, Configs.Colors.surfaceMuted.g, Configs.Colors.surfaceMuted.b, 0
		)

		Behavior on bgColor {
			ColorAnimation {
				duration: 200; easing.type: Easing.InOutQuad
			}
		}


		borderColor: expanded ? Qt.rgba(
			Configs.Colors.outline.r, Configs.Colors.outline.g, Configs.Colors.outline.b, 0
		) : Configs.Colors.outline
		borderWidth: 1

		Layout.alignment: Qt.AlignTop
        Layout.fillWidth: true

        title: Component {
            Item {
                height: 50
                property bool expanded: false
                property var toggle: null

                RowLayout {
					property bool isClipping: parent.implicitWidth < implicitWidth
					visible: !isClipping
					id: titleRow
                    spacing: 10
                    anchors.fill: parent
                    anchors.topMargin: 5
					anchors.bottomMargin: 5

					Item {
						Layout.fillHeight: true
						Layout.preferredWidth: height

						Image {
							id: img
							anchors.fill: parent

							source: root.notif.image
							sourceSize {
								width: width
								height: height
							}

							fillMode: Image.PreserveAspectFit

							onStatusChanged: {
								if (status !== 1) {
									parent.visible = false
								}
							}

						}
					}

                    Text {
						color: Configs.Colors.surfaceFg
                        text: root.notif.summary
                        font.family: Configs.Fonts.fontFamily
                        Layout.fillWidth: true
                        Layout.fillHeight: true
						verticalAlignment: Text.AlignVCenter
                        clip: true
                    }
                }
			
				OpacityMask {
					anchors.fill: titleRow
					source: titleRow
					maskSource: Rectangle {
						width: titleRow.width
						height: titleRow.height
						gradient: Gradient {
							orientation: Gradient.Horizontal
							// GradientStop { position: 0; color: "white" }
							GradientStop { position: 0.7; color: "white" }  // fully visible
							GradientStop { position: 1; color: "transparent" } // faded
						}
					}
					visible: titleRow.isClipping
				}

			}
        }

        content: Component {
            ColumnLayout {
                id: col

				Components.Button {
					Layout.preferredHeight: childrenRect.height
					Layout.fillWidth: true
					variant: Components.Button.ButtonVariant.Ghost
					disabled: !root.notif.hasDefaultAction
					disabledOpacity: 1
					disabledCursor: Qt.ArrowCursor
					onClicked: {
						Services.Notifications.attemptInvokeAction(root.notif.notificationId, "default")
					}

					ColumnLayout {
						anchors.left: parent.left
						anchors.right: parent.right
						anchors.top: parent.top

						Text {
							id: notifSumaryTitleText
							text: root.notif.summary
							font.family: Configs.Fonts.fontFamily
							Layout.fillWidth: true
							color: Configs.Colors.surfaceFg
							wrapMode: Text.WordWrap
							font.bold: true
							anchors.margins: 5
							padding: 10
						}

						Text {
							id: notifBodyText
							text: root.notif.body
							font.family: Configs.Fonts.fontFamily
							Layout.fillWidth: true
							color: Configs.Colors.surfaceFg
							wrapMode: Text.WordWrap
							maximumLineCount: 3
							anchors.margins: 5
							padding: 10

						}

					}

				}

                Repeater {
                    model: root.notif.actions
					delegate: Item {
						required property var modelData
						Layout.fillWidth: true
						height: 40
						Components.Button {
							anchors.leftMargin: 5
							anchors.rightMargin: 5
							anchors.fill: parent
							text: parent.modelData.text
							Layout.fillWidth: true
							variant: Components.Button.ButtonVariant.Ghost
							bgColor: Configs.Colors.surface
							onClicked: Services.Notifications.attemptInvokeAction(root.notif.notificationId, parent.modelData.identifier)
						}
					}
                }
                Item {
                    height: 2
                }
            }
        }
    }

    Components.Button {
		icon: "delete"
        Layout.preferredHeight: 50
        Layout.preferredWidth: 50
        variant: Components.Button.ButtonVariant.Outline
		onClicked: {
			Services.Notifications.discardNotification(root.notif.notificationId)
		}
		Layout.alignment: Qt.AlignTop
    }
}

import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.components as Components
import qs.configs as Configs
import qs.modules.popupcontainer


BasePopup {
    signal controlPress()
    property string currentSession
    property string timeLeft

    id: root
    Item {


        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 10
        anchors.bottomMargin: 10

        ColumnLayout {
            anchors.fill: parent


            spacing: 10


            // Change tomato session time
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true

                // Short break
                Components.Button {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    variant: Components.Button.ButtonVariant.Outline
                    onClicked: cmd.exec(["tomato", "change", "short"])
                    text: "S.Break"
					icon: "coffee"
                }
                
                Components.Button {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    variant: Components.Button.ButtonVariant.Outline
                    onClicked: cmd.exec(["tomato", "change", "pomodoro"])
                    text: "Pomo"
					icon: "work"
                }

                Components.Button {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    variant: Components.Button.ButtonVariant.Outline
                    onClicked: cmd.exec(["tomato", "change", "long"])
                    text: "L.Break"
					icon: "single_bed"
                }
            }

            // Indicator
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true


                // Current session
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Text {
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: Configs.Colors.surfaceFg
                        font.family: Configs.Fonts.fontFamily
                        font.pointSize: 24

                        text: root.currentSession.substring(0, 4).toUpperCase()
                    }
                }

                // Time left
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Text {
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: Configs.Colors.surfaceFg
                        font.family: Configs.Fonts.fontFamily
                        font.pointSize: 24

                        text: root.timeLeft
                    }
                }
            }

            
            Components.Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                onClicked: cmd.exec(["tomato", "start"])
				icon: "play_arrow"
				iconSize: 17
            }


            // Player like
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true


                // Previous phase
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Components.Button {
                        anchors.fill: parent
                        variant: Components.Button.ButtonVariant.Ghost

                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        onClicked: cmd.exec(["tomato", "switch", "down"])
						icon: "arrow_left"
						iconSize: 17
                    }
                }
                // Stop timer
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Components.Button {
                        anchors.fill: parent
                        variant: Components.Button.ButtonVariant.Ghost

                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        onClicked: cmd.exec(["tomato", "stop"])
						icon: "stop"
						iconSize: 17
                    }
                }
                // Next phase
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Components.Button {
                        anchors.fill: parent
                        variant: Components.Button.ButtonVariant.Ghost

                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        onClicked: cmd.exec(["tomato", "switch", "up"])
						icon: "arrow_right"
						iconSize: 17
                    }
                }
            }

            Process {
                id: cmd
                
                onRunningChanged: {
                    if (!running) {
                        root.controlPress()
                    }
                }
            }
        }
    }
}


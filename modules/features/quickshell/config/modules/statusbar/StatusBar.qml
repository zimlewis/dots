import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.modules.statusbar.modules.tomato
import qs.modules.statusbar.modules.clock
import qs.modules.statusbar.modules.workspace
import qs.modules.statusbar.modules.network
import qs.modules.statusbar.modules.volume as Volume
import qs.modules.statusbar.modules.bluetooth
import qs.modules.statusbar.modules.battery
import qs.modules.statusbar.modules.media
import qs.modules.statusbar.modules.pacman
import qs.services as Services
import qs.configs as Configs



PanelWindow {
    readonly property color background: "#1a1b26"
    readonly property color foreground: "#1e2030"
    readonly property color highlight:  "#d1beb0"
    readonly property color empty:      "#dddbf1"
    readonly property string fontFamily: "CaskaydiaMono Nerd Font"
    property double statusBarHeight: 35


    id: statusBar
    color: "transparent"
    implicitHeight: 35
    margins {
        left: 10
        right: 10
        top: 5
    }

    anchors {
        top: true
        left: true
        right: true
    }

    Rectangle {
        id: usableArea
        anchors.fill: parent
        radius: Services.Configuration.configs.borderRadius
        color: Configs.Colors.surface

        border {
            color: Configs.Colors.outline
        }
    }



    Item {
        id: inner
        anchors.fill: usableArea
        anchors.leftMargin: 10
        anchors.rightMargin: 10



        RowLayout {
            anchors.fill: parent
            spacing: 10

            Item {
                id: leftWidget
                Layout.fillHeight: true
                Layout.preferredWidth: Math.max(leftWidget.implicitWidth, rightWidget.implicitWidth)
                implicitWidth: leftInner.implicitWidth  // RowLayout handles the rest

                // Module for left widget go here
                RowLayout {
                    id: leftInner
                    anchors.left : parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    spacing: 10
                    anchors.margins: 0

                    Clock {
                        popupId: "clock"
                        onPop: (x, y, width, height, component, popupId) => {
							Services.PopupController.togglePopup(x, y, width, height, component, popupId)
                        }
                    }

                    Media {
                        popupId: "media"
                        onPop: (x, y, width, height, component, popupId) => {
							Services.PopupController.togglePopup(x, y, width, height, component, popupId)
                        }
                    }

                    Pacman {}
                }
            }

            Item {
                id: centerWidger
                Layout.fillWidth: true
                Layout.fillHeight: true


                // Module for center widget go here
                RowLayout {
                    id: centerInner
                    spacing: 4
                    anchors.margins: 0
                    anchors.fill: parent
                    anchors.centerIn: parent
                    Item { Layout.fillWidth: true }  // left spacer

                    Workspace {
                        popupId: "workspace"
                        onPop: (x, y, width, height, component, popupId) => {
							Services.PopupController.togglePopup(x, y, width, height, component, popupId)
                        }
                    }

                    Item { Layout.fillWidth: true }  // right spacer
                }
            }

            Item {
                id: rightWidget
                Layout.fillHeight: true
                Layout.preferredWidth: Math.max(leftWidget.implicitWidth, rightWidget.implicitWidth)
                implicitWidth: rightInner.implicitWidth


                // Module for right widget go here
                RowLayout {
                    id: rightInner
                    anchors.right : parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    spacing: 4
                    anchors.margins: 0
                    Tomato {
                        popupId: "tomato"
                        onPop: (x, y, width, height, component, popupId) => {
							Services.PopupController.togglePopup(x, y, width, height, component, popupId)
                        }
                    }

                    Network {
                        popupId: "network"
                        onPop: (x, y, width, height, component, popupId) => {
							Services.PopupController.togglePopup(x, y, width, height, component, popupId)
                        }
                    }

                    Volume.Output {
                        popupId: "volumeOutput"
                        onPop: (x, y, width, height, component, popupId) => {
							Services.PopupController.togglePopup(x, y, width, height, component, popupId)
                        }
                    }

                    Volume.Input {
                        popupId: "volumeInput"
                        onPop: (x, y, width, height, component, popupId) => {
							Services.PopupController.togglePopup(x, y, width, height, component, popupId)
                        }
                    }


                    Bluetooth {
                        popupId: "bluetooth"
                        onPop: (x, y, width, height, component, popupId) => {
							Services.PopupController.togglePopup(x, y, width, height, component, popupId)
                        }
                    }

                    Battery {
                        popupId: "battery"
                        onPop: (x, y, width, height, component, popupId) => {
							Services.PopupController.togglePopup(x, y, width, height, component, popupId)
                        }
                    }
                }
            }
        }
    }
}

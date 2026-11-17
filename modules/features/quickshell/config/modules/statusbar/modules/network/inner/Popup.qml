pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Networking
import QtQml.Models

import qs.modules.popupcontainer
import qs.services as Services
import qs.configs as Configs


BasePopup {

    id: root
    readonly property var networkService: Services.Network
    property var networks: networkService.networks

	DelegateModel {
		id: visualModel
		model: root.networkService.networks

		delegate: WifiConnectEntry {
			required property WifiNetwork modelData

			known: modelData.known
			connected: modelData.connected
			signalStrength: modelData.signalStrength * 100
			networkName: modelData?.name ?? ""

			onAttemptConnect: (pass) => { 
				visualModel.sortItems()
				modelData.connectWithPsk(pass)
			}
			onKnownConnect: {
				visualModel.sortItems()
				modelData.connect()
			}
			onForget: {
				visualModel.sortItems()
				modelData.forget()
			}
			onDisconnect: { 
				visualModel.sortItems()
				root.networkService.wifiDevice.disconnect()
			}
		}

		function compareNetworks(a, b) {
			if (a.connected !== b.connected) return a.connected ? -1 : 1
			if (a.known !== b.known) return a.known ? -1 : 1
			return b.signalStrength - a.signalStrength
		}

		function sortItems() {
			// Insertion sort — stable and efficient for nearly-sorted data
			for (let i = 1; i < items.count; i++) {
				for (let j = i; j > 0; j--) {
					const a = items.get(j - 1).model.modelData
					const b = items.get(j).model.modelData
					if (compareNetworks(a, b) > 0) {
						items.move(j - 1, j, 1)
					} else {
						break
					}
				}
			}
		}

		// Re-sort whenever the model adds/removes/changes items
		items.onChanged: sortItems()
	}

    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 20
        anchors.bottomMargin: 20

        Rectangle {
            clip: true
            Layout.fillWidth: true
            Layout.fillHeight: true

            color: Configs.Colors.surfaceMuted
            radius: Services.Configuration.configs.borderRadius
            ScrollView {
                width: parent.width          // fixed horizontal size
                height: parent.height        // fixed vertical size

                
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                contentWidth: availableWidth
                RowLayout {
                    implicitHeight: col.implicitHeight
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    Item {
                        width: 10
                    }
                    ColumnLayout {
                        id: col
                        anchors.topMargin: 10
                        anchors.bottomMargin: 10
                        
                        Item {
                            width: 10
                            implicitHeight: 4
                        }

                        Text {
                            text: "Wifi"
							font.family: Configs.Fonts.fontFamily
							color: Configs.Colors.surfaceFg
                            font.pointSize: 15
                            Layout.fillWidth: true

                            horizontalAlignment: Text.AlignHCenter
                        }

                        Repeater {
							model: visualModel
                        }

                        Item {
                            height: 20
                        }
                    }

                    Item {
                        width: 10
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true

            color: Configs.Colors.surfaceMuted
            radius: Services.Configuration.configs.borderRadius
            implicitHeight: childrenRect.height

            ColumnLayout {
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                implicitHeight: childrenRect.height
                anchors.left: parent.left
                anchors.right: parent.right

                Item {
                    height: 5
                }

                Text {
                    text: "Ethernet"
                    font.family: Configs.Fonts.fontFamily
                    color: Configs.Colors.surfaceFg
                    font.pointSize: 15
                    Layout.fillWidth: true

                    horizontalAlignment: Text.AlignHCenter
                }
                Text {
                    text: root.networkService.ethernetConnected ? "Connected" : "Disconnected" 
                    font.family: Configs.Fonts.fontFamily
                    color: Configs.Colors.surfaceFg
                    font.pointSize: 11
                    Layout.fillWidth: true

                    horizontalAlignment: Text.AlignHCenter

                }
                
                Item {
                    height: 5
                }
            }
        }
    }


    onOpen: {
        networkService.scanWifi();
    }
    onClose: {
        networkService.stopScanningWifi();
    }
}


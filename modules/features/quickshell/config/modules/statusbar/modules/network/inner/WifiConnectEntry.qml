pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.configs as Configs
import qs.components as Components
import qs.services as Services


Components.Dropdown {
    id: root
    required property string networkName
    required property bool known
    required property bool connected
    required property real signalStrength
    property string password
    signal attemptConnect(pass: string)
    signal knownConnect
    signal forget
    signal disconnect

    Layout.fillWidth: true
    bgColor: root.connected ? Configs.Colors.primary : "transparent"
    radius: Services.Configuration.configs.borderRadius


    title: Component {
        Item {
            height: 40
            property bool expanded: false
            property var toggle: null

            RowLayout {
                anchors.fill: parent
                Text {
					color: root.connected ? Configs.Colors.primaryFg : Configs.Colors.surfaceFg 
                    text: root.networkName
                    font.family: Configs.Fonts.fontFamily
                    Layout.fillWidth: true
                    clip: true
                }

                Text {
                    color: root.connected ? Configs.Colors.primaryFg : Configs.Colors.surfaceFg
                    text: root.known ? "k" : ""
                    font.family: Configs.Fonts.fontFamily
                }

                Text {
                    color: root.connected ? Configs.Colors.primaryFg : Configs.Colors.surfaceFg
                    text: {
                        if (root.signalStrength > 66)
                            return "wifi";
                        if (root.signalStrength > 33)
                            return "wifi_2_bar";
                        return "wifi_1_bar";
                    }
                    font.family: Configs.Fonts.iconFamily
                }
            }
        }
    }

    content: connected ? disconnectComponent : contentComponent
    Component {
        id: disconnectComponent

		Item {
            anchors.left: parent.left
            anchors.right: parent.right
			anchors.bottom: parent.bottom
			height: 40
			Components.Button {
				anchors.margins: 5
				anchors.fill: parent

				variant: Components.Button.ButtonVariant.Secondary
				text: "disconnect"
				onClicked: {
					root.disconnect();
				}
			}
		}
    }
    Component {
        id: contentComponent
        ColumnLayout {
            anchors.margins: 5
            Components.Input {
                id: passwordInput
                visible: !known
                Layout.fillWidth: true
                onTextChanged: {
                    root.password = text;
                }
                Connections {
                    target: root
                    function onExpandedChanged() {
                        if (!root.expanded) {
                            parent.focus = false;
                        }
                    }
                }
            }
            Components.Button {
                visible: !known
                Layout.fillWidth: true
                height: 30
                text: "Connect"
                onClicked: {
                    root.attemptConnect(root.password);
                }
            }
            RowLayout {
                anchors.margins: 5
                height: 30
                Components.Button {
                    visible: known
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    variant: Components.Button.ButtonVariant.Secondary
                    text: "Forget"
                    onClicked: {
                        root.forget();
                    }
                }
                Components.Button {
                    visible: known
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    text: "Connect"
                    onClicked: {
                        root.knownConnect();
                    }
                }
            }
        }
    }
}

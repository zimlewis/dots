pragma ComponentBehavior: Bound
import qs.components as Components
import qs.configs as Configs
import qs.services as Services
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets


Components.Dropdown {
    required property SystemTrayItem item

    Layout.fillWidth: true
    id: root
    bgColor: expanded ? Configs.Colors.secondaryContainer : "transparent"

    Behavior on bgColor {
        ColorAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    title: Component {
        Item {
            height: 40
            property bool expanded: false
            property var toggle: null
            

            RowLayout {
                spacing: 10
                anchors.fill: parent
                IconImage {
                    id: img
                    implicitHeight: 16
                    implicitWidth: 16
                    source: root.item.icon

					onStatusChanged: {
						if (status !== 1) {
							source = Qt.resolvedUrl(Services.Directories.imgPath + '/app.svg')
						}
					}
                }

                Text { 
					color:root.expanded ? Configs.Colors.secondaryContainerFg : Configs.Colors.surfaceFg
                    text:  root.item.tooltipTitle
                    font.family: Configs.Fonts.fontFamily
                    Layout.fillWidth: true
                    clip: true
                }
            }

        }
    }

    content: Component {
        ColumnLayout {
            QsMenuOpener {
                menu: root.item.menu
                id: menuOpener
            }
            Repeater {
                model: menuOpener.children 
                delegate: Item {
                    required property var modelData
                    height: modelData.isSeparator ? 1 : 30
                    Layout.fillWidth: true

                    Rectangle {
                        anchors.fill: parent
                        anchors.leftMargin: 5
                        anchors.rightMargin: 5
                        color: Configs.Colors.secondaryContainerFg
						opacity: 0.2
                        visible: parent.modelData.isSeparator
                    }
                    Components.Button {
                        visible: !parent.modelData.isSeparator
                        anchors.fill: parent
                        text: parent.modelData.text
						textColor: Configs.Colors.secondaryContainerFg
                        variant: Components.Button.ButtonVariant.Ghost
                        onClicked: {
                            parent.modelData.triggered()
                        }
                    }
                }
            }

            Item {
                height: 1
            }
        }
    }
}


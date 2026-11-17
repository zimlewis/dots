import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import qs.modules.statusbar.modules.workspace.inner
import qs.modules.statusbar.modules
import qs.components as Components
import qs.configs as Configs



BaseModule {
    id: root
    property int pinnedWorkspace: 5

    Item {
        width: 300
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        RowLayout {
            anchors.centerIn: parent
            Components.Button {
                implicitWidth: 20
                implicitHeight: 20
                variant: Components.Button.ButtonVariant.Ghost

                // color: "red"
                // radius: implicitHeight / 2

				icon: "window"
				iconSize: 15

                Behavior on implicitWidth {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }

                onClicked: mouse => {
                    if (mouse.button === Qt.LeftButton) {
                        const x = area.mapToGlobal(0, 0).x + area.width / 2;
						const y = 200 / 2;
                        root.pop(x, y, 500, 200, workspacePopup, root.popupId)
                    } 
                }
            }

            Rectangle {
                id: area
                implicitWidth: row.implicitWidth + 20
                implicitHeight: row.implicitHeight + 4
                color: Configs.Colors.surfaceMuted

                radius: 10

                RowLayout {
                    id: row
                    spacing: 10
                    anchors.centerIn: parent



                    Repeater {
                        model: root.pinnedWorkspace
                        WorkspaceIndicator {
							required property int index
                            wsIndex: index
                        }
                    }
                }
            }

			WorkspaceIndicator {
				id: exceedWs
				currentWorkspace: Hyprland.workspaces.values.find(w => w.id >= root.pinnedWorkspace + 1)
				wsIndex: root.pinnedWorkspace


				bgColor: isActive ? Configs.Colors.primaryContainer : Configs.Colors.tertiaryContainer
				fgColor: isActive ? Configs.Colors.primaryContainerFg : Configs.Colors.tertiaryContainerFg

			}

        }
    }


    Component {
        id: workspacePopup
        Popup {
        }
    }
}

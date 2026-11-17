import Quickshell.Hyprland
import QtQuick

import qs.configs as Configs


Rectangle {
	id: root
    property int wsIndex
    property var currentWorkspace: Hyprland.workspaces.values.find(w => w.id === wsIndex + 1)
    property var havingWorkspace: currentWorkspace?.toplevels.values.length || 0 >= 1
    property bool isActive: currentWorkspace?.active || false

	property color bgColor: isActive ? Configs.Colors.primaryContainer : (havingWorkspace ? Configs.Colors.secondaryContainer : Configs.Colors.surface)
	property color fgColor: isActive ? Configs.Colors.primaryContainerFg : (havingWorkspace ? Configs.Colors.secondaryContainerFg : Configs.Colors.surfaceFg)

    implicitWidth: isActive ? 50 : 20
    implicitHeight: 20
	// isActive ? Configs.Colors.primary : (havingWorkspace ? Configs.Colors.primaryFg : Configs.Colors.surface)

    color: bgColor
    radius: implicitHeight / 2

    Text {
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: root.isActive ? root.currentWorkspace.id : "" 
        color: root.fgColor
        font.family: Configs.Fonts.fontFamily
    }


    Behavior on implicitWidth {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${ root.wsIndex + 1 } })`)
    }
}

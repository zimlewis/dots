import qs.components as Components
import Quickshell
import QtQuick.Layouts
import QtQuick


Components.Button {
	id: root

    property bool forceCircle: false

    implicitHeight: 30
    implicitWidth: 30
	variant: Components.Button.ButtonVariant.Ghost

}

import QtQuick
import QtQuick.Controls.FluentWinUI3
import QtQuick.Controls

TextField {
    id: root
    
    clip: true
    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter
    color: "white"
    activeFocusOnTab: false

    font {
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton
        hoverEnabled: true
        cursorShape: Qt.IBeamCursor
    }
}

import QtQuick
import QtQuick.Layouts


Item {
    property string popupId: ""

    signal open()
    signal pop(x: double, y: double, width: double, height: double, component: Component, popupId: string)

    width: children[0].width ?? 0
    Layout.fillHeight: true

    
    Component.onCompleted: {
    }
}

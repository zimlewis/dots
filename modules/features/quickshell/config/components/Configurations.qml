import QtQuick

QtObject {
    id: root

    enum ColorMode {
        Adaptive = 0,
        Light = 1,
        Dark = 2
    }

    property real borderRadius
    property int colorMode
	property string fontFamily
	property int fontSizeSmall
	property int fontSizeNormal
	property int fontSizeLarge
}

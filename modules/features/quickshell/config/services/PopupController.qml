pragma Singleton

import QtQuick
import Quickshell

Singleton {
	signal togglePopup(real x, real y, real width, real height, Component component, string popupId)
	signal closePopup()
}

pragma Singleton

import QtQuick
import Quickshell

// Psuedo Material Palette that use hsl because there's no native hct implementation at the moment(and probably never will)
Singleton {
    // Key color definitions — only H and S, tone is passed at call site
    readonly property real primaryH:        0.67
    readonly property real primaryS:        0.72

    readonly property real secondaryH:      0.29
    readonly property real secondaryS:      0.74

    readonly property real tertiaryH:       0.06
    readonly property real tertiaryS:       0.56

    readonly property real errorH:          0.0
    readonly property real errorS:          0.85
	
    readonly property real neutralH:        primaryH
    readonly property real neutralS:        0.21

    readonly property real neutralVariantH: primaryH
    readonly property real neutralVariantS: 0.30


    // tone: 0–1
    function primary(l, a)        { return Qt.hsla(primaryH,        primaryS,        l, a) }
    function secondary(l, a)      { return Qt.hsla(secondaryH,      secondaryS,      l, a) }
    function tertiary(l, a)       { return Qt.hsla(tertiaryH,       tertiaryS,       l, a) }
    function error(l, a)          { return Qt.hsla(errorH,          errorS,          l, a) }
    function neutral(l, a)        { return Qt.hsla(neutralH,        neutralS,        l, a) }
    function neutralVariant(l, a) { return Qt.hsla(neutralVariantH, neutralVariantS, l, a) }
}

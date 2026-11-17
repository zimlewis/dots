pragma Singleton

import QtQuick
import Quickshell

import qs.configs
import qs.services as Services
import qs.components as Components


Singleton {
	readonly property bool lightMode: {
		return Services.Configuration.configs.colorMode === Components.Configurations.ColorMode.Light
	}

	property double bgLightness: 0.6
	property double fgLightness: 0.9

	property double containerBgLightness: 0.8
	property double containerFgLightness: 0.3

	property double surfaceDimLightness: lightMode ? 0.8 : 0.15
	property double surfaceBrightLightness: lightMode ? 0.85 : 0.20

	property double surfaceFgLightness: lightMode ? 0.2 : 0.8
	property double surfaceVariantFgLightness: lightMode ? 0.2 : 0.8

	property double outlineLightness: lightMode ? 0.68 : 0.32
	property double outlineVariantLightness: lightMode ? 0.68 : 0.32 

	property double inverseSurfaceLightness: lightMode ? 0.2 : 0.8
	property double inverseSurfaceFgLightness: lightMode ? 0.22 : 0.18

    readonly property color primary: KeyPalette.primary(bgLightness, 1)
    readonly property color primaryFg: KeyPalette.primary(fgLightness, 1)

    readonly property color secondary: KeyPalette.secondary(bgLightness, 1)
    readonly property color secondaryFg: KeyPalette.secondary(fgLightness, 1)

    readonly property color tertiary: KeyPalette.tertiary(bgLightness, 1)
    readonly property color tertiaryFg: KeyPalette.tertiary(fgLightness, 1)

	readonly property color error: KeyPalette.error(bgLightness, 1)
	readonly property color errorFg: KeyPalette.error(fgLightness, 1)

	readonly property color primaryContainer: KeyPalette.primary(containerBgLightness, 1)
	readonly property color primaryContainerFg: KeyPalette.primary(containerFgLightness, 1)

	readonly property color secondaryContainer: KeyPalette.secondary(containerBgLightness, 1)
	readonly property color secondaryContainerFg: KeyPalette.secondary(containerFgLightness, 1)

	readonly property color tertiaryContainer: KeyPalette.tertiary(containerBgLightness, 1)
	readonly property color tertiaryContainerFg: KeyPalette.tertiary(containerFgLightness, 1)

	readonly property color errorContainer: KeyPalette.error(containerFgLightness, 1)
	readonly property color errorContainerFg: KeyPalette.error(containerFgLightness, 1)

	readonly property color surfaceDim: KeyPalette.neutral(surfaceDimLightness, 1)
	readonly property color surfaceBright: KeyPalette.neutral(surfaceBrightLightness, 1)

	// Depend on the dark and light mode, will switch for each other
	readonly property color surface: lightMode ? surfaceBright : surfaceDim
	readonly property color surfaceMuted: lightMode ? surfaceDim : surfaceBright

	readonly property color surfaceFg: KeyPalette.neutral(surfaceFgLightness, 1)
	readonly property color surfaceVariantFg: KeyPalette.neutralVariant(surfaceVariantFgLightness, 1)

	readonly property color outline: KeyPalette.neutral(outlineLightness, 0.5)
	readonly property color outlineVariant: KeyPalette.neutralVariant(outlineVariantLightness, 0.5)

	readonly property color inverseSurface: KeyPalette.neutral(inverseSurfaceLightness, 1)
	readonly property color inverseSurfaceFg: KeyPalette.neutral(inverseSurfaceFgLightness, 1)
}

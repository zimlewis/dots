pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.UPower 

Singleton {
	id: root

	property UPowerDevice displayDevice: UPower.displayDevice

	property bool available: UPower.displayDevice.isLaptopBattery
	property var chargeState: UPower.displayDevice.state

	property var isCharging: chargeState === UPowerDeviceState.Charging
	property bool isPluggedIn: isCharging || chargeState === UPowerDeviceState.PendingCharge
	property bool isFullyCharged: chargeState === UPowerDeviceState.FullyCharged

	property real percentage: UPower.displayDevice.percentage ?? 1

	property bool isLow: available && (percentage <= .2)
	property bool isCritical: available && (percentage <= .1)
	property bool isFull: available && (percentage >= .9)

    property bool isLowAndNotCharging: isLow && !isCharging
    property bool isCriticalAndNotCharging: isCritical && !isCharging

    property real energyRate: UPower.displayDevice.changeRate
    property real timeToEmpty: UPower.displayDevice.timeToEmpty
    property real timeToFull: UPower.displayDevice.timeToFull

	onChargeStateChanged: {
		console.log(UPower.displayDevice.state)
	}


	property string displayIcon: {
		if (!available) return "plug_connect";
		if (isCharging || isFullyCharged) return "battery_android_bolt";

        return "battery_android_0";
	}

    onIsLowAndNotChargingChanged: {
        if (!root.available || !isLowAndNotCharging) return;
        Quickshell.execDetached([
            "notify-send", 
            "Low battery",
            "Consider plugging in your device",
            "-u", "critical",
            "-a", "Shell",
            "--hint=int:transient:1",
        ])
    }

    onIsCriticalAndNotChargingChanged: {
        if (!root.available || !isCriticalAndNotCharging) return;
        Quickshell.execDetached([
            "notify-send", 
            "Critically low battery",
            "Please charge!\n",
            "-u", "critical",
            "-a", "Shell",
            "--hint=int:transient:1",
        ]);
    }
}

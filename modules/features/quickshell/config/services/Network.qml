// NetworkService.qml
pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Networking

Singleton {
    id: root
	
	property string ipAddress: "0.0.0.0"
    readonly property var service: Networking

    // ── Derived state ────────────────────────────────────────────────
    readonly property var wifiDevices: {
        const devs = [];
        for (const dev of service.devices.values) {
            if (dev.type === NetworkDevice.Wifi)
                devs.push(dev);
        }
        return devs;
    }
    readonly property var wifiDevice: {
        return wifiDevices.find(d => d.state === ConnectionState.Connected) ?? wifiDevices[0] ?? null;
    }

    readonly property var ethernetDevices: {
        const devs = [];
        for (const dev of service.devices.values) {
            if (dev.type === NetworkDevice.Wired)
                devs.push(dev);
        }
        return devs;
    }
    readonly property var ethernetDevice: {
        return ethernetDevices.find(d => d.state === ConnectionState.Connected) ?? ethernetDevices[0] ?? null;
    }

    // ── WiFi convenience props ───────────────────────────────────────
    readonly property bool wifiAvailable: wifiDevice !== null
    readonly property bool wifiConnected: wifiDevice?.state === ConnectionState.Connected ?? false
    readonly property var connectedWifi: wifiDevice?.networks.values.find(n => n.connected == true) ?? null
    readonly property string wifiSsid: connectedWifi?.name ?? ""
    readonly property int wifiStrength: (connectedWifi?.signalStrength ?? 0) * 100
    readonly property bool isWifiScanning: wifiDevice?.scannerEnabled ?? false
    readonly property bool wifiConnecting: wifiDevice?.state == ConnectionState.Connecting ?? false
	readonly property var networks: wifiDevice?.networks

	// readonly property alias networks: networksList

    ListModel {
        id: networksList
    }

    Timer {
        id: scanStopTimer
        interval: 2000
        repeat: false
        onTriggered: root.stopScanningWifi()
    }



    onIsWifiScanningChanged: {
        // if (isWifiScanning) {
        //     scanStopTimer.start();
        // }
    }

    // ── Ethernet convenience props ───────────────────────────────────
    readonly property bool ethernetAvailable: ethernetDevice !== null
    readonly property bool ethernetConnected: ethernetDevice?.state === ConnectionState.Connected ?? false
    readonly property bool ethernetConnecting: ethernetDevice?.state == ConnectionState.Connecting ?? false

    // ── Unified "best connection" for top-level status ───────────────
    readonly property bool online: wifiConnected || ethernetConnected

    readonly property string statusIcon: {
        if (ethernetConnected) return " ";
        if (wifiConnected) {
			if (wifiStrength > 66) return "wifi";
			if (wifiStrength > 33) return "wifi_2_bar";
			return "wifi_1_bar";
        }
        if (wifiConnecting || ethernetConnecting) return "android_wifi_3_bar_question";
        return "android_wifi_3_bar_off";  // disconnected
    }

    readonly property string statusLabel: {
        if (ethernetConnected)
            return "Ethernet";
        if (wifiConnected)
            return wifiSsid;
        if (wifiConnecting)
            return "Connecting…";
        if (ethernetConnecting)
            return "Connecting…";
        return "Disconnected";
    }

    function stopScanningWifi() {
        if (wifiDevice === null) {
            return;
        }

        wifiDevice.scannerEnabled = false;
    }

    function scanWifi() {
        if (wifiDevice === null) {
            return;
        }

        wifiDevice.scannerEnabled = true;
    }

	onNetworksChanged: {
		ipProcess.running = true
	}

	Process {
        id: ipProcess
        // Shell command that extracts the local IPv4 address for the active device
        command: ["sh", "-c", "ip -4 -o addr show wlan0 | awk '{print $4}' | cut -d/ -f1"]
        running: true
        
        stdout: StdioCollector {
            onStreamFinished: (data) => {
                root.ipAddress = data.toString().trim()
            }
        }
	}

	function getLanIP() {

	}
}

pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Io

/**
 * A nice wrapper for date and time strings.
 */
Singleton {
	id: root
    property var clock: SystemClock {
        precision: {
            return SystemClock.Minutes;
        }
    }
    property string time: Qt.locale().toString(clock.date, "hh:mm")
    property string shortDate: Qt.locale().toString(clock.date, "dd/MM")
    property string date: Qt.locale().toString(clock.date, "dd/MM/yyyy")
    property string longDate: Qt.locale().toString(clock.date, "dddd, dd/MM")
    property string collapsedCalendarFormat: Qt.locale().toString(clock.date, "dddd, MMMM dd")
    property string uptime: "0m, 0s"

    Timer {
        interval: 10
        running: true
        repeat: true
        onTriggered: {
            fileUptime.reload();
            const textUptime = fileUptime.text();
            const uptimeSeconds = Number(textUptime.split(" ")[0] ?? 0);

            // Convert seconds to days, hours, and minutes
            const days = Math.floor(uptimeSeconds / 86400);
            const hours = Math.floor((uptimeSeconds % 86400) / 3600);
            const minutes = Math.floor((uptimeSeconds % 3600) / 60);
			const seconds = Math.floor(uptimeSeconds % 60)

            // Build the formatted uptime string
            let formatted = "";
            if (days > 0) formatted += `${days}d`;
            if (hours > 0) formatted += `${formatted ? ", " : ""}${hours}h`;
            if (minutes > 0) formatted += `${formatted ? ", " : ""}${minutes}m`;
			formatted += `${formatted ? ", " : ""}${seconds}s`
            root.uptime = formatted;
            interval = 100;
        }
    }

    FileView {
        id: fileUptime

        path: "/proc/uptime"
    }
}

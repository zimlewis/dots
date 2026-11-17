pragma Singleton

import Quickshell.Services.Mpris 
import QtQuick
import Quickshell

Singleton {
	id: root

	property ObjectModel players: Mpris.players
	property string trackedPlayerId

	property int trackedPlayerIndex: {
		if (trackedPlayer === null) { return -1 }

		return players.values.indexOf(trackedPlayer)
	}

    property MprisPlayer trackedPlayer: {
        if (trackedPlayerId !== "") {
            const match = root.players.values.find(p => p.dbusName === trackedPlayerId)
            if (match) return match
        }

		const playing = root.players.values.find(p => p.isPlaying)
		if (playing) {
			trackedPlayerId = playing.dbusName
			return playing
		}

		const first = root.players[0]
		if (first) {
			trackedPlayerId = first.dbusName
			return first
		}

        return null
    }

}

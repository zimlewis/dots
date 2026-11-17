pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

import qs.modules.popupcontainer
import qs.services as Services
import qs.configs as Configs
import qs.components as Components
import "calendar_layout.js" as CalendarLayout

BasePopup {
	id: root

	anchors.leftMargin: 10
	anchors.rightMargin: 10
	anchors.topMargin: 5
	anchors.bottomMargin: 5

    property int monthShift: 0
    property var viewingDate: CalendarLayout.getDateInXMonthsTime(monthShift)
    property var calendarLayout: CalendarLayout.getCalendarLayout(viewingDate, monthShift === 0)


	RowLayout {
		anchors.fill: parent
		ColumnLayout {
			id: calendarColumn
			spacing: 5

			RowLayout {
				Layout.fillWidth: true
				Layout.fillHeight: true

				Text {
					text: {
						const format = root.monthShift != 0 ? "MMMM yyyy" : "dd MMMM yyyy"
						return `${root.monthShift != 0 ? "• " : ""}${root.viewingDate.toLocaleDateString(Qt.locale(), format)}`
					}
					font.family: Configs.Fonts.fontFamily
					font.pointSize: 12
					color: Configs.Colors.surfaceFg
					verticalAlignment: Text.AlignVCenter
					Layout.fillWidth: true
					Layout.fillHeight: true
				}
				Item {
					Layout.fillWidth: true
					Layout.fillHeight: true
				}
				CalendarHeaderButton {
					onClicked: {
						root.monthShift -= 1
					}
					text: "-"
					buttonRadius: width / 2
				}
				CalendarHeaderButton {
					onClicked: {
						root.monthShift += 1
					}
					text: "+"
					buttonRadius: width / 2
				}
			
			}

			RowLayout {
				Layout.fillHeight: true
				Layout.fillWidth: true
				spacing: 10
				ColumnLayout {
					Layout.fillHeight: true
					RowLayout {
						id: weekDaysRow
						Layout.alignment: Qt.AlignHCenter
						Layout.fillHeight: false
						spacing: 5
						Repeater {
							model: CalendarLayout.weekDays
							delegate: CalendarDayButton {
								required property var modelData
								day: modelData.day
								isToday: modelData.today == 1
								bold: true
								enabled: false
								variant: Components.Button.ButtonVariant.Ghost
							}
						}
					}
					Repeater {
						id: calendarRows
						// model: calendarLayout
						model: 6
						delegate: RowLayout {
							required property var modelData
							Layout.alignment: Qt.AlignHCenter
							Layout.fillHeight: false
							spacing: 5
							Repeater {
								model: Array(7).fill(parent.modelData)
								delegate: CalendarDayButton {
									required property var modelData
									required property int index
									day: root.calendarLayout[modelData][index].day
									isToday: root.calendarLayout[modelData][index].today === 1
									disabled: true
									buttonRadius: width / 2

									variant: root.calendarLayout[modelData][index].today === -1 ? Components.Button.ButtonVariant.Ghost : Components.Button.ButtonVariant.Outline
								}
							}
						}
					}
				

				}
				Rectangle {
					Layout.fillHeight: true
					Layout.fillWidth: true
					color: Configs.Colors.surfaceMuted
					radius: Services.Configuration.configs.borderRadius
				}
			}
			Item {
				Layout.fillHeight: true
			}
		}
	}
}

// qml/components/Calendar.qml
import QtQuick 6.9
import QtQuick.Layouts 1.15
import QtQuick.Controls 6.9
import "."

Item {
    id: calendar_component
    property var calendarBackend: null
    property var dateObject: new Date()
    property bool expanded: true

    ColumnLayout {
        anchors.fill: parent
        spacing: 5

            Text {
                text: calendarBackend ? calendarBackend.month_name : "Loading..."
                font.pointSize: 20
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
            }

        GridLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            columns: 7
            columnSpacing: 5
            rowSpacing: 5

            Repeater {
                model: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                delegate: Text {
                    text: model.modelData
                    font.family: "Arial"
                    font.pointSize: 14
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillWidth: true
                }
            }

            Repeater {
                model: calendarBackend ? calendarBackend.calendarModel : null
                delegate: DateCell {
                    date: model.date
                    hasNotes: model.hasNotes
                    fullDate: model.fullDate
                    onClicked: if (model.date !== "") console.log("Clicked date:", model.date, "Full Date:", model.fullDate)
                }
            }
        }
    }
}



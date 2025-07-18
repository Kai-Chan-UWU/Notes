// /components/Calendar.qml
import QtQuick 6.9
import QtQuick.Layouts 1.15
import QtQuick.Controls 6.9
import "."
import "../utils/ui.js" as Utils

Rectangle {
    id: calendar_component
    radius: 8
    color: "#ffffffcc"
    border.color: "#cccccc"
    border.width: 1
    Layout.rightMargin: 30
    Layout.leftMargin: 10

    property var calendarBackend: null
    property var dateObject: new Date()
    property bool expanded: true

    ColumnLayout {
        anchors.fill: parent
        spacing: 5

        Rectangle {
            color: "transparent"
            radius: 4
            Layout.fillWidth: true
            Layout.topMargin: 10
            Layout.bottomMargin: 5
            height: 40

            Text {
                anchors.centerIn: parent
                text: calendarBackend ? calendarBackend.month_name : "Loading..."
                font.pointSize: 18
                font.bold: true
                }
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
                }
            }
        }
    }
}



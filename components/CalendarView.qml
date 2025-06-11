import QtQuick 6.9
import QtQuick.Layouts 1.15
import QtQuick.Controls 6.9 

Item {
    id: calendar
    
    property var dateObject

    ColumnLayout {
        anchors.fill: parent

        DayOfWeekRow {
            locale: Qt.locale("en_US")
            Layout.fillWidth: true
        }

        MonthGrid {
            id: grid
            month: dateObject.getMonth()
            year: dateObject.getFullYear()
            locale: Qt.locale("en_US")
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}


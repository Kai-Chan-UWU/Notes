// qml/components/DateCell.qml
import QtQuick 6.9
import QtQuick.Layouts 1.15

CustomButton {
    property string date: ""
    property bool hasNotes: false
    property var fullDate: null

    background: null // No button visuals

    contentItem: Item {
        anchors.fill: parent

        // Red circle for today
        Rectangle {
            visible: fullDate && date !== "" &&
                     parseInt(fullDate.day) === new Date().getDate() &&
                     parseInt(fullDate.month) === (new Date().getMonth() + 1) &&
                     parseInt(fullDate.year) === new Date().getFullYear()
            width: 30
            height: 30
            radius: 15
            color: "red"
            anchors.centerIn: parent
        }

        // Date text with underline if hasNotes
        Text {
            text: date
            font.pointSize: 18
            color: date === "" ? "transparent" : "black"
            font.underline: hasNotes
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.centerIn: parent
        }
    }

    Layout.fillWidth: true
    Layout.fillHeight: true
}


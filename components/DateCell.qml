// /components/DateCell.qml
import QtQuick 6.9
import QtQuick.Layouts 1.15
import "../utils/ui.js" as Utils

CustomButton {

    property string date: ""
    property bool hasNotes: false
    property var fullDate: null

    Layout.fillWidth: true
    Layout.fillHeight: true
    background: null // No button visuals
    hoverEnabled: true

    contentItem: Item {
        anchors.fill: parent

        // Red circle for today
        Rectangle {
            visible: Utils.isToday(fullDate)
            width: 35
            height: 35
            radius: 18
            color: "red"
            anchors.centerIn: parent
            z: 1
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
            z: 1
        }

        Rectangle {
            anchors.centerIn: parent
            width: 35
            height: 35
            radius: 18
            color: hovered ? "#eeeeee" : "transparent"
            z: -1
        }
    }

    Component.onCompleted: {
        if ( model.date !== "" && Utils.isToday(fullDate)) {
            eventBridge.dayClicked(Utils.formatDate(model.fullDate))
        }
    }

    onClicked: {
        if (model.date !== "" && model.fullDate !== "") {
            eventBridge.dayClicked(Utils.formatDate(model.fullDate))
        } else {
            console.log("No date")
        }
    }
}


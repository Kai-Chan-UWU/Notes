// /components/NoteView.qml
import QtQuick 6.9
import QtQuick.Layouts 1.15
import QtQuick.Controls 6.9
import "../utils/ui.js" as Utils

Rectangle {
    id: noteView
    radius: 8
    color: "#ffffffcc"
    border.color: "#cccccc"
    border.width: 1
    Layout.rightMargin: 10
    Layout.leftMargin: 30

    property string title: Utils.getFormattedDate(new Date())

    ColumnLayout {
        anchors.fill: parent
        spacing: 5

        Text {
            id: noteView_title
            text: title
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            Layout.preferredHeight: 30  // Ensures fixed height at the top
            Layout.topMargin: 10
            Layout.bottomMargin: 5
            font.bold: true
            font.pointSize: 18
        }

        ScrollView {
            id: noteView_scroll
            Layout.fillWidth: true
            Layout.fillHeight: true  // Makes ScrollView take up remaining space
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            clip: true

            TextArea {
                id: noteView_text
                Layout.fillWidth: true
                Layout.fillHeight: true  // Ensures TextArea fills ScrollView
                font.pixelSize: 18
                wrapMode: TextEdit.WordWrap
                color: "black"
                selectByMouse: true
                textFormat: Text.PlainText
                verticalAlignment: Text.AlignTop
                placeholderText: "Start Writing your notes here..."
                placeholderTextColor: "black"

                Component.onCompleted: {
                    noteView_text.focus = true;
                }
            }
        }
    }

    Connections {
        target: eventBridge
        function onDayClicked (day) {
            title = day;
        }
    }
}

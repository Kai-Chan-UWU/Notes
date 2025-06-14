// /components/NoteView.qml
import QtQuick 6.9
import QtQuick.Layouts 1.15
import QtQuick.Controls 6.9

Rectangle {
    id: noteView
    color: "transparent"

    property string title: ""

    ColumnLayout {
        anchors.fill: parent
        spacing: 5

        Text {
            id: noteView_title
            text: title ? title : ""
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            Layout.preferredHeight: 30  // Ensures fixed height at the top
            font.bold: true
            font.pixelSize: 20
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
}

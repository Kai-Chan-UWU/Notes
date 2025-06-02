import QtQuick 6.9
import QtQuick.Layouts 1.15

Window {
    width: 1080
    height: 700
    minimumWidth: 700
    minimumHeight: 600
    visible: true
    title: "Notes"

    NoteEditor {
        anchors.fill: parent
    }
}

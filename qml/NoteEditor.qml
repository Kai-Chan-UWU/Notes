import QtQuick 6.9
import QtQuick.Layouts 1.15
import QtQuick.Controls 6.9 // Needed for ScrollView
import "../utils/ui.js" as Utils
import "../components"

Rectangle {
    id: noteEditorRoot // Id of parent rectangle

    Image { // background image
        id: bg
        anchors.fill: parent
        source: "../assets/bg.jpeg"
        fillMode: Image.PreserveAspectCrop
        z: -1 // Sending the image to background
    }

    Rectangle {
        id: page // Inner rectangle, acts as the main content area
        anchors.fill: parent // Takes the full screen of the parent rectangle
        color: "transparent"

        // Main content layout
        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            // Title and upper row navigation
            Item {
                id: upperNav
                Layout.preferredHeight: 60 // Explicit height for upperNav to ensure it takes space
                Layout.fillWidth: true // Allows it to take available width
                Layout.topMargin: 10 // Add top margin to the content
                Layout.leftMargin: 10 // Add left margin
                Layout.rightMargin: 10 // Add right margin

                RowLayout {
                    anchors.fill: parent // Fills the Item's space
                    spacing: 10

                    // Back button
                    CustomButton {
                        iconSource: "../assets/icons/left-arrow.png" // Placeholder icon
                        tooltipText: "Back"
                        onClicked: {
                            console.log("Back button pressed");
                            title.text = Utils.getFormattedDate( new Date())
                            noteContentEditor.text = "";
                        }
                    }

                    Item { Layout.fillWidth: true } // Spacer to push title to center

                    // Daily Title - This will be updated by opened file's title
                    Text {
                        id: title // Heading of the page
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.pixelSize: parent.width / 30
                        color: "black"
                        textFormat: Text.StyledText
                        // Initial text for the title, will be overwritten if a file is opened
                        text: Utils.getFormattedDate(new Date()) 
                    }

                    Item { Layout.fillWidth: true } // Spacer to push title to center

                    // Close button
                    CustomButton {
                        iconSource: "../assets/icons/close.png" // Placeholder icon
                        tooltipText: "Close"
                        onClicked: {
                            console.log("Close button pressed");
                            title.text = "";
                            noteContentEditor.text = "";
                        }
                    }
                }
            }

            // Scrollable Text Editor area
            ScrollView {
                id: editorScrollView
                Layout.fillHeight: true // Takes remaining vertical space
                Layout.fillWidth: true // Takes full horizontal width
                Layout.leftMargin: 10 // Add left margin to the editor
                Layout.rightMargin: 10 // Add right margin to the editor
                clip: true // Prevents content drawing outside bounds

                TextArea {
                    id: noteContentEditor
                    width: parent.width // Fills scroll view width
                    height: parent.height

                    font.pixelSize: 18
                    wrapMode: TextEdit.WordWrap // Wraps text
                    color: 'black'
                    selectByMouse: true // Enables mouse selection
                    textFormat: Text.PlainText // Plain text format

                    verticalAlignment: Text.AlignTop // Aligns text to top

                    placeholderText: "Start Writing your notes here..." // Hint text
                    placeholderTextColor: "black"

                    Component.onCompleted: {
                        noteContentEditor.focus = true; // Sets initial focus
                    }
                }
            }
        }

        // Floating lower navigation bar
        Rectangle {
            id: lowerNavFloatingBar
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
            width: 460
            height: 50
            radius: 25
            color: "#AAFFFFFF"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 5
                spacing: 15
                Layout.alignment: Qt.AlignHCenter

                CustomButton {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    iconSource: "../assets/icons/save.png"
                    tooltipText: "Save"
                    onClicked: {
                        fileHandler.saveFileDialog() // Trigger Python save dialog
                        // This console log will show *before* the file is actually saved
                        // due to the asynchronous nature of dialogs and signals.
                        // The actual "File Saved" message should come from the signal handler.
                    }
                }
                CustomButton {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    iconSource: "../assets/icons/search.png" // Using this for "Open"
                    tooltipText: "Open Note"
                    onClicked: {
                        fileHandler.openFileDialog() // Trigger Python open dialog
                    }
                }
                CustomButton {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    iconSource: "../assets/icons/close.png"
                    tooltipText: "Close"
                    onClicked: console.log("File Closed");
                }
                CustomButton {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    iconSource: "../assets/icons/delete.png"
                    tooltipText: "File Deleted"
                    onClicked: console.log("File Deleted");
                }
            }
        }
    }

    // --- ADDED: Text elements to display the paths ---
    Text {
        id: uploadedFilePathText
        text: "Last Opened: (None)"
        font.pixelSize: 14
        color: "gray"
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 10
        width: parent.width / 2 - 15
        horizontalAlignment: Text.AlignLeft
        wrapMode: Text.WrapAnywhere
    }

    Text {
        id: downloadedFilePathText
        text: "Last Saved: (None)"
        font.pixelSize: 14
        color: "gray"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10
        width: parent.width / 2 - 15
        horizontalAlignment: Text.AlignRight
        wrapMode: Text.WrapAnywhere
    }

    // --- Connections block for Python backend signals ---
    Connections {
        target: fileHandler

        // Handler for when the save dialog is closed and a path is confirmed
        function onSavePathConfirmed(filePath) { // Parameter name changed to filePath for clarity
            downloadedFilePathText.text = "Last Saved: " + (filePath ? filePath : "(Cancelled)")
            if (filePath) {
                console.log("QML: Received save path: " + filePath)
                // Now, call the Python function to actually save the content
                fileHandler.saveTextToFile(filePath, noteContentEditor.text)
            } else {
                console.log("QML: File save operation cancelled.")
            }
        }

        // Handler for when the open dialog is closed and a path is selected
        function onFilePathSelected(filePath) { // Parameter name changed to filePath for clarity
            uploadedFilePathText.text = "Last Opened: " + (filePath ? filePath : "(Cancelled)")
            if (filePath) {
                console.log("QML: File path received from Python (for opening): " + filePath)
                // Now, call the Python function to open and read the file content
                fileHandler.openFile(filePath)
            } else {
                console.log("QML: File open operation cancelled.")
            }
        }

        // Handler for when the file content is successfully read by Python
        function onFileContentOpened(titleName, content) { // Renamed signal and parameters for clarity
            if (titleName && content) {
                title.text = titleName // Update the title text
                noteContentEditor.text = content // Set the editor content
                console.log("QML: Content loaded successfully.")
            } else {
                console.log("QML: Failed to load file content (or cancelled).")
            }
        }
    }
}

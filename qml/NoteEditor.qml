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
        fillMode: Image.PreserveAspectFill
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
                        onClicked: console.log("Back button pressed");
                    }

                    Item { Layout.fillWidth: true } // Spacer to push title to center

                    // Daily Title
                    Text {
                        id: title // Heading of the page
                        // Removed Layout.fillWidth: true from here, as spacers will manage width distribution
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter // Centers text within its own bounds
                        font.pixelSize: parent.width / 30 // Font size that adapts to window size
                        color: "black" // Font color
                        textFormat: Text.StyledText // Using StyledText to use bold and underline tags
                        text: Utils.getFormattedDate(new Date()) + Utils.getFormattedTime(new Date()) // Formatted date and time
                    }

                    Item { Layout.fillWidth: true } // Spacer to push title to center

                    // Close button
                    CustomButton {
                        iconSource: "../assets/icons/close.png" // Placeholder icon
                        tooltipText: "Close"
                        onClicked: console.log("Close button pressed");
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
                    height: contentHeight // Height expands with content

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

        // Floating lower navigation bar (no changes needed here based on current feedback)
        Rectangle {
            id: lowerNavFloatingBar
            // Positioned relative to the 'page' rectangle, floating above content
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40 // Distance from the bottom of the page
            width: 460 // Fixed width for the floating bar
            height: 50 // Fixed height for the floating bar
            radius: 25 // Rounded corners for a softer look
            color: "#AAFFFFFF" // Semi-transparent white for a "floating" effect

            // RowLayout for buttons inside the floating bar
            RowLayout {
                anchors.fill: parent // Fills the floating bar
                anchors.margins: 5 // Apply margins to the RowLayout to create internal spacing
                spacing: 15 // Spacing between buttons
                Layout.alignment: Qt.AlignHCenter // Center the row of buttons horizontally

                // Placeholder buttons (adjust count as needed, e.g., 4 or 5)
                CustomButton {
                    Layout.preferredWidth: 40 // All buttons same fixed width
                    Layout.preferredHeight: 40 // All buttons same fixed height
                    iconSource: "../assets/icons/circle.png" // Placeholder icon
                    tooltipText: "Option 1"
                    onClicked: console.log("Option 1 clicked");
                }
                CustomButton {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    iconSource: "../assets/icons/link.png" // Placeholder icon
                    tooltipText: "Option 2"
                    onClicked: console.log("Option 2 clicked");
                }
                CustomButton {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    iconSource: "../assets/icons/search.png" // Placeholder icon
                    tooltipText: "Option 3"
                    onClicked: console.log("Option 3 clicked");
                }
                CustomButton {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    iconSource: "../assets/icons/ai.png" // Placeholder icon
                    tooltipText: "Option 4"
                    onClicked: console.log("Option 4 clicked");
                }
            }
        }
    }
}


import QtQuick 6.9
import QtQuick.Layouts 1.15
import QtQuick.Controls 6.9 // Needed for ScrollView 
import "../utils/ui.js" as Utils

Rectangle {
    id: noteEditorRoot  // Id of parent rectangle

    Image {     // background
        id: bg
        anchors.fill: parent
        source: "../assets/bg.jpeg"
        fillMode: Image.PreserveAspectFit
        z: -1   // Sending the image to background
    }


    Rectangle {
        id: page   // Inner rectangle
        anchors.fill: parent   // Takes the full screen of the parent rectangle
        

        // Title and upper row
        Item {
            id: upperNav
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            height: title.y + title.height + 15   // height between item top and titl top + title height + extra padding
            // Back button

            // Daily Title
            Text {
                id: title       // Heading of the page
                anchors { 
                    horizontalCenter: parent.horizontalCenter    // Centering the text to the middle of the window
                    top: parent.top             // moving it to the top
                    topMargin: 20               // lowering it by 20 pixels
                }
                font.pixelSize: parent.width / 30                   // font size that adapts to window size
                color: "black"                                      // font color
                textFormat: Text.StyledText                         // Using StyledText to use bold and underline tags
                text: Utils.getFormattedDate( new Date()) + Utils.getFormattedTime( new Date())    // making it bold and giving underline
                
            }
        }

        // Scrollabe Text Edittor
        ScrollView {
            id: editorScrollView
            // Responsible for content scrolling
            anchors {
                top: upperNav.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                // Add padding around the scroll view
                leftMargin: 10
                rightMargin: 10
                bottomMargin: 10
            }
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
                    noteContentEditor.focus = true;     // Sets initial focus
                }
            }
        }
    }
}

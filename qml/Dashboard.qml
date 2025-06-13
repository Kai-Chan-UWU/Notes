import QtQuick 6.9
import QtQuick.Layouts 1.15
import QtQuick.Controls 6.9
import "../components/" // Adjust if your components are in a different relative path

Rectangle {
    id: dashboardRoot
    // You might want to define width/height here or let the ApplicationWindow size it.
    // If this is the root of your window:
    // width: 1024
    // height: 768

    Image {
        id: bg
        anchors.fill: parent
        source: "../assets/bg.jpeg"
        fillMode: Image.PreserveAspectCrop
        z: -2
    }

    Item { // Navbar remains the same, assuming it's positioned correctly
        id: navbar
        width: parent.width
        height: 60
        anchors.top: parent.top
        z: 1

        RowLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            CustomButton {
                iconSource: "../assets/icons/menu.png"
                tooltipText: "Menu"
                Layout.alignment: Qt.AlignVCenter
                onClicked: console.log("Menu Opened")
            }

            Item { Layout.fillWidth: true }

            Image {
                id: logo
                source: "../assets/icons/navlogo.png"
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: 160
                Layout.preferredHeight: 40
                sourceSize.width: 160
                sourceSize.height: 40
            }

            Item { Layout.fillWidth: true }

            CustomButton {
                iconSource: "../assets/icons/plus.png"
                tooltipText: "Custom Notes"
                Layout.alignment: Qt.AlignVCenter
                onClicked: console.log("Add Custom Notes")
            }

            CustomButton {
                iconSource: "../assets/icons/search.png"
                tooltipText: "Search"
                Layout.alignment: Qt.AlignVCenter
                onClicked: console.log("Search Notes")
            }
        }
    }

    // --- Main Content Area (Scrollable) ---
    ScrollView {
        id: mainContentScroll
        anchors.top: navbar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 10
        clip: true // Ensure content outside bounds is clipped

        // IMPORTANT: The contentItem of ScrollView should be a single Item or Layout
        // that defines its intrinsic size based on its children.
        // We want this ColumnLayout to determine its overall height.
        contentItem: ColumnLayout {
            id: mainDashboardContentLayout
            width: mainContentScroll.width // Very important: Match ScrollView's width
            spacing: 20 // Spacing between major sections

            // --- Calendar Section ---
            RowLayout {
                Layout.fillWidth: true // Allow this row to fill the width of mainDashboardContentLayout
                Layout.alignment: Qt.AlignHCenter // Center the content of this RowLayout horizontally

                Item { Layout.fillWidth: true } // Left spacer

                CalendarView { // Make sure this component name matches your file name: CalendarView.qml
                    // Give the CalendarView its preferred dimensions.
                    // These will be respected by the surrounding Layouts.
                    Layout.preferredWidth: 400
                    Layout.preferredHeight: 400 // Calendar needs height to show all rows
                    calendarBackend: calBackend  // Ensure this name matches your Python context property
                }
                Item { Layout.fillWidth: true } // Right spacer
            }

            // --- Other Dashboard Content ---

        }
    }
}

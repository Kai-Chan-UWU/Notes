import QtQuick 6.9
import QtQuick.Layouts 1.15
import QtQuick.Controls 6.9
import "../components/"

Rectangle {
    id: dashboardRoot

    Image {
        id: bg
        anchors.fill: parent
        source: "../assets/bg.jpeg"
        fillMode: Image.PreserveAspectCrop
        z: -2
    }

    Item {
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
    ScrollView {
        anchors.top: navbar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 10

        Item {
            width: parent.width

            ColumnLayout {
                width: parent.width
                spacing: 10

                /* RowLayout {
                    width: parent.width
                    spacing: 5

                    Repeater {
                        model: 3
                        Rectangle {
                            Layout.fillWidth: true
                            height: 40
                            border.width: 1
                            color: "red"
                        }
                    }
                }
                */
                Item {
                    width: parent.width
                    RowLayout {
                        width: parent.width
    
                        Item { Layout.fillWidth: true }
                    
                        CalendarView {
                            dateObject: new Date()
                            width: 500
                            height: 300
                        }
                    }
                }

                RowLayout {
                    width: parent.width

                    Rectangle {
                        height: 1000
                        Layout.fillWidth: true
                        color: "transparent"
                    }
                }
            }
        }
    }
}


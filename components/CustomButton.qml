// components/CutomButtom.qml
import QtQuick 6.9
import QtQuick.Layouts 1.15
import QtQuick.Controls 6.9 // Needed for ScrollView 

Button {
    // Mandatory
    property string iconSource: ""  // path to the icon
    property int iconSize: 24   //default icon size
    property string tooltipText: ""     // text for the tooltip

    // --- Button Config ---
    icon.source: iconSource
    icon.width: iconSize
    icon.height: iconSize

    // --- Tooltip Configuration
    // Only show tooltip if tooltipText is provided
    ToolTip.text: tooltipText
    ToolTip.visible: hovered && tooltipText.length > 0
    ToolTip.delay: 500  // Standard delay for tooltips

    // More Styling
    background: Rectangle {
        implicitWidth: 50 // Minimum size
        implicitHeight: 50
        radius: 5
        color: "transparent"
        border.color: "transparent"
        border.width: parent.hovered ? 1 : 0
    }
}

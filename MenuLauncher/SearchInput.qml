import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

TextField {
    id: id
    Layout.fillWidth: true
    padding: 12
    font.pixelSize: 16
    placeholderText: "Search apps..."
    placeholderTextColor: '#DCD7BA'
    color: "#DCD7BA"
    background: Rectangle {
        color: "#2A2A37"
        radius: 6
        border.color: id.activeFocus ? "#DCD7BA" : "#363646"
    }

    Component.onCompleted: {
        id.forceActiveFocus();
    }
}
